package backend;

import lime.utils.Assets as LimeAssets;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import flash.system.System;

/**
 * ...
 * @author: Saw (M.A. Jigsaw)
 */

class SUtil
{
	#if android
	private static var aDir:String = null; // android dir
	#end

	public static function getPath():String
	{
		#if android
		if (aDir != null && aDir.length > 0)
			return aDir;
		else
		{
			// Penyimpanan internal aplikasi: tanpa izin storage dan tanpa ekstrak manual
			aDir = Path.addTrailingSlash(lime.system.System.applicationStorageDirectory);
			return aDir;
		}
		#else
		return '';
		#end
	}

	/**
	 * Menyalin aset dari APK (assets/ dan mods/) ke penyimpanan aplikasi saat pertama dibuka
	 * atau setelah APK diperbarui. Kegagalan satu file TIDAK menghentikan proses: file yang gagal
	 * dicatat ke assets_copy_errors.txt. (Aset yang di-embed lime tidak bisa dibaca sebagai Bytes
	 * dan memunculkan "Invalid cast"; itu sebabnya setiap file ditangani terpisah.)
	 */
	public static function doTheCheck()
	{
		#if android
		var base:String = SUtil.getPath();
		var idFile:String = base + 'assets/build_id.txt';

		var apkId:String = 'unknown';
		try
		{
			var t:String = OpenFlAssets.getText('assets/build_id.txt');
			if (t != null) apkId = StringTools.trim(t);
		}
		catch (e:Dynamic) {}

		var diskId:String = null;
		try { if (FileSystem.exists(idFile)) diskId = StringTools.trim(File.getContent(idFile)); }
		catch (e:Dynamic) {}
		if (diskId == apkId)
			return;

		var errors:Array<String> = [];
		try { removeDir(base + 'assets'); } catch (e:Dynamic) { errors.push('hapus assets: ' + Std.string(e)); }
		try { removeDir(base + 'mods'); } catch (e:Dynamic) { errors.push('hapus mods: ' + Std.string(e)); }

		var copied:Int = 0;
		for (libName in ['default', 'songs', 'shared', 'week_assets', 'videos'])
		{
			if (!LimeAssets.hasLibrary(libName))
				continue;
			var lib = LimeAssets.getLibrary(libName);
			if (lib == null)
				continue;

			for (id in lib.list(null))
			{
				if (!(StringTools.startsWith(id, 'assets/') || StringTools.startsWith(id, 'mods/')))
					continue;
				if (id == 'assets/build_id.txt')
					continue;

				if (copyOne(lib, id, base + id, errors))
					copied++;
			}
		}

		try
		{
			if (errors.length > 0)
			{
				makeDirs(base);
				File.saveContent(base + 'assets_copy_errors.txt', errors.join('\n'));
			}
		}
		catch (e:Dynamic) {}

		if (copied == 0)
		{
			SUtil.applicationAlert('Error', 'Tidak ada file game yang berhasil disalin.\n' + (errors.length > 0 ? errors[0] : ''));
			System.exit(0);
		}

		// Ditulis paling akhir: kalau proses terputus, akan diulang pada peluncuran berikutnya
		try
		{
			makeDirs(Path.directory(idFile));
			File.saveContent(idFile, apkId);
		}
		catch (e:Dynamic) {}
		#end
	}

	/**
	 * Mencoba menyalin satu aset. Mengembalikan true jika berhasil.
	 * Teks dibaca lewat getText, selain itu getBytes; kalau keduanya gagal, dicatat lalu dilewati.
	 */
	private static function copyOne(lib:lime.utils.AssetLibrary, id:String, dest:String, errors:Array<String>):Bool
	{
		var ext:String = Path.extension(id).toLowerCase();
		var isText:Bool = ['json', 'txt', 'lua', 'hx', 'hscript', 'xml', 'ini', 'csv', 'tsv', 'frag', 'vert'].indexOf(ext) != -1;

		var firstError:String = null;
		if (isText)
		{
			try
			{
				makeDirs(Path.directory(dest));
				File.saveContent(dest, lib.getText(id));
				return true;
			}
			catch (e:Dynamic) { firstError = Std.string(e); }
		}

		try
		{
			makeDirs(Path.directory(dest));
			File.saveBytes(dest, lib.getBytes(id));
			return true;
		}
		catch (e:Dynamic)
		{
			errors.push(id + ' -> ' + (firstError != null ? firstError + ' / ' : '') + Std.string(e));
			return false;
		}
	}

	private static function makeDirs(dir:String):Void
	{
		if (dir == null || dir.length == 0 || FileSystem.exists(dir))
			return;
		makeDirs(Path.directory(dir));
		FileSystem.createDirectory(dir);
	}

	private static function removeDir(dir:String):Void
	{
		if (!FileSystem.exists(dir))
			return;
		for (f in FileSystem.readDirectory(dir))
		{
			var path:String = dir + '/' + f;
			if (FileSystem.isDirectory(path))
				removeDir(path);
			else
				FileSystem.deleteFile(path);
		}
		FileSystem.deleteDirectory(dir);
	}

	public static function gameCrashCheck()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
	}

	public static function onCrash(e:UncaughtErrorEvent):Void
	{
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		dateNow = StringTools.replace(dateNow, " ", "_");
		dateNow = StringTools.replace(dateNow, ":", "'");

		var path:String = "crash/" + "crash_" + dateNow + ".txt";
		var errMsg:String = "";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += e.error;

		if (!FileSystem.exists(SUtil.getPath() + "crash"))
		FileSystem.createDirectory(SUtil.getPath() + "crash");

		File.saveContent(SUtil.getPath() + path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));
		Sys.println("Making a simple alert ...");

		SUtil.applicationAlert("Uncaught Error :(!", errMsg);
		System.exit(0);
	}

	private static function applicationAlert(title:String, description:String)
	{
		Application.current.window.alert(description, title);
	}

	#if android
	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json', fileData:String = 'you forgot something to add in your code')
	{
		if (!FileSystem.exists(SUtil.getPath() + 'saves'))
			FileSystem.createDirectory(SUtil.getPath() + 'saves');

		File.saveContent(SUtil.getPath() + 'saves/' + fileName + fileExtension, fileData);
		SUtil.applicationAlert('Done :)!', 'File Saved Successfully!');
	}
    
    public static function AutosaveContent(fileName:String = 'file', fileExtension:String = '.json', fileData:String = 'you forgot something to add in your code')
	{
		if (!FileSystem.exists(SUtil.getPath() + 'saves'))
			FileSystem.createDirectory(SUtil.getPath() + 'saves');

		File.saveContent(SUtil.getPath() + 'saves/' + fileName + fileExtension, fileData);
		//SUtil.applicationAlert('Done :)!', 'File Saved Successfully!');
	}
	
	public static function saveClipboard(fileData:String = 'you forgot something to add in your code')
	{
		openfl.system.System.setClipboard(fileData);
		SUtil.applicationAlert('Done :)!', 'Data Saved to Clipboard Successfully!');
	}

	public static function copyContent(copyPath:String, savePath:String)
	{
		if (!FileSystem.exists(savePath))
			File.saveBytes(savePath, OpenFlAssets.getBytes(copyPath));
	}
	#end
} 
