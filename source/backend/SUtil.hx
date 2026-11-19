package backend;

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
	 * Menyalin aset yang dibundel di dalam APK (assets/ dan mods/) ke penyimpanan aplikasi
	 * saat pertama dibuka atau setelah APK diperbarui, jadi pemain tidak perlu ekstrak manual.
	 */
	public static function doTheCheck()
	{
		#if android
		var base:String = SUtil.getPath();
		var idFile:String = base + 'assets/build_id.txt';

		var apkId:String = null;
		try { apkId = OpenFlAssets.getText('assets/build_id.txt'); } catch (e:Dynamic) {}
		apkId = (apkId == null) ? 'unknown' : StringTools.trim(apkId);

		var diskId:String = null;
		try { if (FileSystem.exists(idFile)) diskId = StringTools.trim(File.getContent(idFile)); } catch (e:Dynamic) {}
		if (diskId == apkId)
			return;

		try
		{
			removeDir(base + 'assets');
			removeDir(base + 'mods');

			// Use OpenFL's public asset API instead of casting/iterating Lime's private
			// library map, which can fail at runtime on Android with "Invalid Cast".
			var assetIds:Array<String> = OpenFlAssets.list();
			for (id in assetIds)
			{
				if (!(StringTools.startsWith(id, 'assets/') || StringTools.startsWith(id, 'mods/')))
					continue;
				if (id == 'assets/build_id.txt')
					continue;

				var bytes = OpenFlAssets.getBytes(id);
				if (bytes == null)
					continue;

				var dest:String = base + id;
				makeDirs(Path.directory(dest));
				File.saveBytes(dest, bytes);
			}

			// Ditulis paling akhir: kalau proses salin terputus, akan diulang pada peluncuran berikutnya
			makeDirs(Path.directory(idFile));
			File.saveContent(idFile, apkId);
		}
		catch (e:Dynamic)
		{
			SUtil.applicationAlert('Error', 'Gagal menyiapkan file game:\n' + Std.string(e));
			System.exit(0);
		}
		#end
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
