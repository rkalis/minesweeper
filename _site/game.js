
var Module;

if (typeof Module === 'undefined') Module = eval('(function() { try { return Module || {} } catch(e) { return {} } })()');

if (!Module.expectedDataFileDownloads) {
  Module.expectedDataFileDownloads = 0;
  Module.finishedDataFileDownloads = 0;
}
Module.expectedDataFileDownloads++;
(function() {
 var loadPackage = function(metadata) {

    var PACKAGE_PATH;
    if (typeof window === 'object') {
      PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    } else if (typeof location !== 'undefined') {
      // worker
      PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
    } else {
      throw 'using preloaded data can only be done on a web page or in a web worker';
    }
    var PACKAGE_NAME = 'game.data';
    var REMOTE_PACKAGE_BASE = 'game.data';
    if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
      Module['locateFile'] = Module['locateFilePackage'];
      Module.printErr('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
    }
    var REMOTE_PACKAGE_NAME = typeof Module['locateFile'] === 'function' ?
                              Module['locateFile'](REMOTE_PACKAGE_BASE) :
                              ((Module['filePackagePrefixURL'] || '') + REMOTE_PACKAGE_BASE);
  
    var REMOTE_PACKAGE_SIZE = metadata.remote_package_size;
    var PACKAGE_UUID = metadata.package_uuid;
  
    function fetchRemotePackage(packageName, packageSize, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        var size = packageSize;
        if (event.total) size = event.total;
        if (event.loaded) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: size
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
          var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onload = function(event) {
        var packageData = xhr.response;
        callback(packageData);
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };
  
      var fetched = null, fetchedCallback = null;
      fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, function(data) {
        if (fetchedCallback) {
          fetchedCallback(data);
          fetchedCallback = null;
        } else {
          fetched = data;
        }
      }, handleError);
    
  function runWithFS() {

    function assert(check, msg) {
      if (!check) throw msg + new Error().stack;
    }
Module['FS_createPath']('/', '.git', true, true);
Module['FS_createPath']('/.git', 'hooks', true, true);
Module['FS_createPath']('/.git', 'info', true, true);
Module['FS_createPath']('/.git', 'logs', true, true);
Module['FS_createPath']('/.git/logs', 'refs', true, true);
Module['FS_createPath']('/.git/logs/refs', 'heads', true, true);
Module['FS_createPath']('/.git/logs/refs', 'remotes', true, true);
Module['FS_createPath']('/.git/logs/refs/remotes', 'origin', true, true);
Module['FS_createPath']('/.git', 'objects', true, true);
Module['FS_createPath']('/.git/objects', '00', true, true);
Module['FS_createPath']('/.git/objects', '02', true, true);
Module['FS_createPath']('/.git/objects', '03', true, true);
Module['FS_createPath']('/.git/objects', '05', true, true);
Module['FS_createPath']('/.git/objects', '08', true, true);
Module['FS_createPath']('/.git/objects', '09', true, true);
Module['FS_createPath']('/.git/objects', '0a', true, true);
Module['FS_createPath']('/.git/objects', '0b', true, true);
Module['FS_createPath']('/.git/objects', '0d', true, true);
Module['FS_createPath']('/.git/objects', '0e', true, true);
Module['FS_createPath']('/.git/objects', '0f', true, true);
Module['FS_createPath']('/.git/objects', '10', true, true);
Module['FS_createPath']('/.git/objects', '11', true, true);
Module['FS_createPath']('/.git/objects', '12', true, true);
Module['FS_createPath']('/.git/objects', '13', true, true);
Module['FS_createPath']('/.git/objects', '14', true, true);
Module['FS_createPath']('/.git/objects', '15', true, true);
Module['FS_createPath']('/.git/objects', '16', true, true);
Module['FS_createPath']('/.git/objects', '19', true, true);
Module['FS_createPath']('/.git/objects', '1c', true, true);
Module['FS_createPath']('/.git/objects', '1f', true, true);
Module['FS_createPath']('/.git/objects', '20', true, true);
Module['FS_createPath']('/.git/objects', '22', true, true);
Module['FS_createPath']('/.git/objects', '27', true, true);
Module['FS_createPath']('/.git/objects', '29', true, true);
Module['FS_createPath']('/.git/objects', '2b', true, true);
Module['FS_createPath']('/.git/objects', '2c', true, true);
Module['FS_createPath']('/.git/objects', '2e', true, true);
Module['FS_createPath']('/.git/objects', '31', true, true);
Module['FS_createPath']('/.git/objects', '35', true, true);
Module['FS_createPath']('/.git/objects', '36', true, true);
Module['FS_createPath']('/.git/objects', '37', true, true);
Module['FS_createPath']('/.git/objects', '38', true, true);
Module['FS_createPath']('/.git/objects', '39', true, true);
Module['FS_createPath']('/.git/objects', '3a', true, true);
Module['FS_createPath']('/.git/objects', '3b', true, true);
Module['FS_createPath']('/.git/objects', '3c', true, true);
Module['FS_createPath']('/.git/objects', '3e', true, true);
Module['FS_createPath']('/.git/objects', '3f', true, true);
Module['FS_createPath']('/.git/objects', '40', true, true);
Module['FS_createPath']('/.git/objects', '41', true, true);
Module['FS_createPath']('/.git/objects', '43', true, true);
Module['FS_createPath']('/.git/objects', '46', true, true);
Module['FS_createPath']('/.git/objects', '47', true, true);
Module['FS_createPath']('/.git/objects', '48', true, true);
Module['FS_createPath']('/.git/objects', '4a', true, true);
Module['FS_createPath']('/.git/objects', '4b', true, true);
Module['FS_createPath']('/.git/objects', '4c', true, true);
Module['FS_createPath']('/.git/objects', '4e', true, true);
Module['FS_createPath']('/.git/objects', '4f', true, true);
Module['FS_createPath']('/.git/objects', '51', true, true);
Module['FS_createPath']('/.git/objects', '52', true, true);
Module['FS_createPath']('/.git/objects', '55', true, true);
Module['FS_createPath']('/.git/objects', '56', true, true);
Module['FS_createPath']('/.git/objects', '57', true, true);
Module['FS_createPath']('/.git/objects', '5a', true, true);
Module['FS_createPath']('/.git/objects', '5c', true, true);
Module['FS_createPath']('/.git/objects', '5d', true, true);
Module['FS_createPath']('/.git/objects', '5e', true, true);
Module['FS_createPath']('/.git/objects', '5f', true, true);
Module['FS_createPath']('/.git/objects', '60', true, true);
Module['FS_createPath']('/.git/objects', '61', true, true);
Module['FS_createPath']('/.git/objects', '63', true, true);
Module['FS_createPath']('/.git/objects', '65', true, true);
Module['FS_createPath']('/.git/objects', '66', true, true);
Module['FS_createPath']('/.git/objects', '67', true, true);
Module['FS_createPath']('/.git/objects', '68', true, true);
Module['FS_createPath']('/.git/objects', '69', true, true);
Module['FS_createPath']('/.git/objects', '6b', true, true);
Module['FS_createPath']('/.git/objects', '6d', true, true);
Module['FS_createPath']('/.git/objects', '6e', true, true);
Module['FS_createPath']('/.git/objects', '6f', true, true);
Module['FS_createPath']('/.git/objects', '72', true, true);
Module['FS_createPath']('/.git/objects', '73', true, true);
Module['FS_createPath']('/.git/objects', '74', true, true);
Module['FS_createPath']('/.git/objects', '75', true, true);
Module['FS_createPath']('/.git/objects', '76', true, true);
Module['FS_createPath']('/.git/objects', '77', true, true);
Module['FS_createPath']('/.git/objects', '78', true, true);
Module['FS_createPath']('/.git/objects', '79', true, true);
Module['FS_createPath']('/.git/objects', '7a', true, true);
Module['FS_createPath']('/.git/objects', '7d', true, true);
Module['FS_createPath']('/.git/objects', '7e', true, true);
Module['FS_createPath']('/.git/objects', '80', true, true);
Module['FS_createPath']('/.git/objects', '81', true, true);
Module['FS_createPath']('/.git/objects', '82', true, true);
Module['FS_createPath']('/.git/objects', '83', true, true);
Module['FS_createPath']('/.git/objects', '84', true, true);
Module['FS_createPath']('/.git/objects', '86', true, true);
Module['FS_createPath']('/.git/objects', '87', true, true);
Module['FS_createPath']('/.git/objects', '88', true, true);
Module['FS_createPath']('/.git/objects', '8c', true, true);
Module['FS_createPath']('/.git/objects', '90', true, true);
Module['FS_createPath']('/.git/objects', '94', true, true);
Module['FS_createPath']('/.git/objects', '95', true, true);
Module['FS_createPath']('/.git/objects', '97', true, true);
Module['FS_createPath']('/.git/objects', '98', true, true);
Module['FS_createPath']('/.git/objects', '99', true, true);
Module['FS_createPath']('/.git/objects', '9a', true, true);
Module['FS_createPath']('/.git/objects', '9b', true, true);
Module['FS_createPath']('/.git/objects', '9e', true, true);
Module['FS_createPath']('/.git/objects', '9f', true, true);
Module['FS_createPath']('/.git/objects', 'a0', true, true);
Module['FS_createPath']('/.git/objects', 'a1', true, true);
Module['FS_createPath']('/.git/objects', 'a2', true, true);
Module['FS_createPath']('/.git/objects', 'a3', true, true);
Module['FS_createPath']('/.git/objects', 'a5', true, true);
Module['FS_createPath']('/.git/objects', 'a8', true, true);
Module['FS_createPath']('/.git/objects', 'a9', true, true);
Module['FS_createPath']('/.git/objects', 'aa', true, true);
Module['FS_createPath']('/.git/objects', 'ab', true, true);
Module['FS_createPath']('/.git/objects', 'ac', true, true);
Module['FS_createPath']('/.git/objects', 'ae', true, true);
Module['FS_createPath']('/.git/objects', 'af', true, true);
Module['FS_createPath']('/.git/objects', 'b0', true, true);
Module['FS_createPath']('/.git/objects', 'b1', true, true);
Module['FS_createPath']('/.git/objects', 'b2', true, true);
Module['FS_createPath']('/.git/objects', 'b5', true, true);
Module['FS_createPath']('/.git/objects', 'b6', true, true);
Module['FS_createPath']('/.git/objects', 'b7', true, true);
Module['FS_createPath']('/.git/objects', 'ba', true, true);
Module['FS_createPath']('/.git/objects', 'bc', true, true);
Module['FS_createPath']('/.git/objects', 'bd', true, true);
Module['FS_createPath']('/.git/objects', 'be', true, true);
Module['FS_createPath']('/.git/objects', 'c0', true, true);
Module['FS_createPath']('/.git/objects', 'c1', true, true);
Module['FS_createPath']('/.git/objects', 'c2', true, true);
Module['FS_createPath']('/.git/objects', 'c3', true, true);
Module['FS_createPath']('/.git/objects', 'c7', true, true);
Module['FS_createPath']('/.git/objects', 'c9', true, true);
Module['FS_createPath']('/.git/objects', 'ca', true, true);
Module['FS_createPath']('/.git/objects', 'cb', true, true);
Module['FS_createPath']('/.git/objects', 'cf', true, true);
Module['FS_createPath']('/.git/objects', 'd0', true, true);
Module['FS_createPath']('/.git/objects', 'd1', true, true);
Module['FS_createPath']('/.git/objects', 'd3', true, true);
Module['FS_createPath']('/.git/objects', 'd4', true, true);
Module['FS_createPath']('/.git/objects', 'd5', true, true);
Module['FS_createPath']('/.git/objects', 'd6', true, true);
Module['FS_createPath']('/.git/objects', 'd7', true, true);
Module['FS_createPath']('/.git/objects', 'd9', true, true);
Module['FS_createPath']('/.git/objects', 'da', true, true);
Module['FS_createPath']('/.git/objects', 'db', true, true);
Module['FS_createPath']('/.git/objects', 'e0', true, true);
Module['FS_createPath']('/.git/objects', 'e2', true, true);
Module['FS_createPath']('/.git/objects', 'e4', true, true);
Module['FS_createPath']('/.git/objects', 'e6', true, true);
Module['FS_createPath']('/.git/objects', 'e7', true, true);
Module['FS_createPath']('/.git/objects', 'e8', true, true);
Module['FS_createPath']('/.git/objects', 'e9', true, true);
Module['FS_createPath']('/.git/objects', 'ea', true, true);
Module['FS_createPath']('/.git/objects', 'ec', true, true);
Module['FS_createPath']('/.git/objects', 'ee', true, true);
Module['FS_createPath']('/.git/objects', 'ef', true, true);
Module['FS_createPath']('/.git/objects', 'f1', true, true);
Module['FS_createPath']('/.git/objects', 'f4', true, true);
Module['FS_createPath']('/.git/objects', 'f5', true, true);
Module['FS_createPath']('/.git/objects', 'fa', true, true);
Module['FS_createPath']('/.git/objects', 'fb', true, true);
Module['FS_createPath']('/.git/objects', 'fc', true, true);
Module['FS_createPath']('/.git/objects', 'fe', true, true);
Module['FS_createPath']('/.git/objects', 'pack', true, true);
Module['FS_createPath']('/.git', 'refs', true, true);
Module['FS_createPath']('/.git/refs', 'heads', true, true);
Module['FS_createPath']('/.git/refs', 'remotes', true, true);
Module['FS_createPath']('/.git/refs/remotes', 'origin', true, true);
Module['FS_createPath']('/', '.idea', true, true);
Module['FS_createPath']('/', 'assets', true, true);
Module['FS_createPath']('/assets', 'audio', true, true);
Module['FS_createPath']('/assets', 'graphics', true, true);
Module['FS_createPath']('/', 'lib', true, true);
Module['FS_createPath']('/', 'spec', true, true);
Module['FS_createPath']('/', 'src', true, true);
Module['FS_createPath']('/src', 'ui', true, true);
Module['FS_createPath']('/', 'states', true, true);

    function DataRequest(start, end, crunched, audio) {
      this.start = start;
      this.end = end;
      this.crunched = crunched;
      this.audio = audio;
    }
    DataRequest.prototype = {
      requests: {},
      open: function(mode, name) {
        this.name = name;
        this.requests[name] = this;
        Module['addRunDependency']('fp ' + this.name);
      },
      send: function() {},
      onload: function() {
        var byteArray = this.byteArray.subarray(this.start, this.end);

          this.finish(byteArray);

      },
      finish: function(byteArray) {
        var that = this;

        Module['FS_createDataFile'](this.name, null, byteArray, true, true, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
        Module['removeRunDependency']('fp ' + that.name);

        this.requests[this.name] = null;
      },
    };

        var files = metadata.files;
        for (i = 0; i < files.length; ++i) {
          new DataRequest(files[i].start, files[i].end, files[i].crunched, files[i].audio).open('GET', files[i].filename);
        }

  
    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;
      
        // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though
        // (we may be allocating before malloc is ready, during startup).
        if (Module['SPLIT_MEMORY']) Module.printErr('warning: you should run the file packager with --no-heap-copy when SPLIT_MEMORY is used, otherwise copying into the heap may fail due to the splitting');
        var ptr = Module['getMemory'](byteArray.length);
        Module['HEAPU8'].set(byteArray, ptr);
        DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);
  
          var files = metadata.files;
          for (i = 0; i < files.length; ++i) {
            DataRequest.prototype.requests[files[i].filename].onload();
          }
              Module['removeRunDependency']('datafile_game.data');

    };
    Module['addRunDependency']('datafile_game.data');
  
    if (!Module.preloadResults) Module.preloadResults = {};
  
      Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
      if (fetched) {
        processPackageData(fetched);
        fetched = null;
      } else {
        fetchedCallback = processPackageData;
      }
    
  }
  if (Module['calledRun']) {
    runWithFS();
  } else {
    if (!Module['preRun']) Module['preRun'] = [];
    Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
  }

 }
 loadPackage({"files": [{"audio": 0, "start": 0, "crunched": 0, "end": 1397, "filename": "/conf.lua"}, {"audio": 0, "start": 1397, "crunched": 0, "end": 2475, "filename": "/LICENSE"}, {"audio": 0, "start": 2475, "crunched": 0, "end": 1479109, "filename": "/LuaSweeper.love"}, {"audio": 0, "start": 1479109, "crunched": 0, "end": 1482242, "filename": "/main.lua"}, {"audio": 0, "start": 1482242, "crunched": 0, "end": 1487128, "filename": "/README.md"}, {"audio": 0, "start": 1487128, "crunched": 0, "end": 1487156, "filename": "/.git/COMMIT_EDITMSG"}, {"audio": 0, "start": 1487156, "crunched": 0, "end": 1487462, "filename": "/.git/config"}, {"audio": 0, "start": 1487462, "crunched": 0, "end": 1487535, "filename": "/.git/description"}, {"audio": 0, "start": 1487535, "crunched": 0, "end": 1487625, "filename": "/.git/FETCH_HEAD"}, {"audio": 0, "start": 1487625, "crunched": 0, "end": 1487648, "filename": "/.git/HEAD"}, {"audio": 0, "start": 1487648, "crunched": 0, "end": 1491873, "filename": "/.git/index"}, {"audio": 0, "start": 1491873, "crunched": 0, "end": 1491914, "filename": "/.git/ORIG_HEAD"}, {"audio": 0, "start": 1491914, "crunched": 0, "end": 1492021, "filename": "/.git/packed-refs"}, {"audio": 0, "start": 1492021, "crunched": 0, "end": 1492367, "filename": "/.git/sourcetreeconfig"}, {"audio": 0, "start": 1492367, "crunched": 0, "end": 1492845, "filename": "/.git/hooks/applypatch-msg.sample"}, {"audio": 0, "start": 1492845, "crunched": 0, "end": 1493741, "filename": "/.git/hooks/commit-msg.sample"}, {"audio": 0, "start": 1493741, "crunched": 0, "end": 1493930, "filename": "/.git/hooks/post-update.sample"}, {"audio": 0, "start": 1493930, "crunched": 0, "end": 1494354, "filename": "/.git/hooks/pre-applypatch.sample"}, {"audio": 0, "start": 1494354, "crunched": 0, "end": 1495996, "filename": "/.git/hooks/pre-commit.sample"}, {"audio": 0, "start": 1495996, "crunched": 0, "end": 1497344, "filename": "/.git/hooks/pre-push.sample"}, {"audio": 0, "start": 1497344, "crunched": 0, "end": 1502295, "filename": "/.git/hooks/pre-rebase.sample"}, {"audio": 0, "start": 1502295, "crunched": 0, "end": 1502839, "filename": "/.git/hooks/pre-receive.sample"}, {"audio": 0, "start": 1502839, "crunched": 0, "end": 1504078, "filename": "/.git/hooks/prepare-commit-msg.sample"}, {"audio": 0, "start": 1504078, "crunched": 0, "end": 1507688, "filename": "/.git/hooks/update.sample"}, {"audio": 0, "start": 1507688, "crunched": 0, "end": 1507928, "filename": "/.git/info/exclude"}, {"audio": 0, "start": 1507928, "crunched": 0, "end": 1514933, "filename": "/.git/logs/HEAD"}, {"audio": 0, "start": 1514933, "crunched": 0, "end": 1521782, "filename": "/.git/logs/refs/heads/master"}, {"audio": 0, "start": 1521782, "crunched": 0, "end": 1521965, "filename": "/.git/logs/refs/remotes/origin/HEAD"}, {"audio": 0, "start": 1521965, "crunched": 0, "end": 1525397, "filename": "/.git/logs/refs/remotes/origin/master"}, {"audio": 0, "start": 1525397, "crunched": 0, "end": 1526344, "filename": "/.git/objects/00/4c43be5ca007b7a5386885c09aca5850afdf77"}, {"audio": 0, "start": 1526344, "crunched": 0, "end": 1526429, "filename": "/.git/objects/00/ad95a87bf674727c1131b84cfc82329697ef33"}, {"audio": 0, "start": 1526429, "crunched": 0, "end": 1526826, "filename": "/.git/objects/02/41bfeb850e57eaad7376d5269b5e4521255ca4"}, {"audio": 0, "start": 1526826, "crunched": 0, "end": 1527038, "filename": "/.git/objects/02/6f614bfeb5dda1e45d8f160ee7a5ba9517a75f"}, {"audio": 0, "start": 1527038, "crunched": 0, "end": 1530596, "filename": "/.git/objects/02/7d700b61e2b3fdcfd3bffbeb851399e6dd90ce"}, {"audio": 0, "start": 1530596, "crunched": 0, "end": 1530886, "filename": "/.git/objects/03/3f53a002df56881745d8698d560ec9d13c6c1a"}, {"audio": 0, "start": 1530886, "crunched": 0, "end": 1531300, "filename": "/.git/objects/05/c5bbbb376b49d650846e60d29b9b9bfa582f85"}, {"audio": 0, "start": 1531300, "crunched": 0, "end": 1531640, "filename": "/.git/objects/08/56b1b758056f8a46836c72e850c7de00383cf5"}, {"audio": 0, "start": 1531640, "crunched": 0, "end": 1532041, "filename": "/.git/objects/09/371067ebb57e386871f3ba5c74eac53f34d0b8"}, {"audio": 0, "start": 1532041, "crunched": 0, "end": 1532439, "filename": "/.git/objects/09/7eb7e5744cba11e7408b2f45bd15d7afe1079b"}, {"audio": 0, "start": 1532439, "crunched": 0, "end": 1532730, "filename": "/.git/objects/0a/c667077e016e8fb3c3639c91e6ffcbf67aa098"}, {"audio": 0, "start": 1532730, "crunched": 0, "end": 1532906, "filename": "/.git/objects/0b/7cc354104c4c06830434c95d72027e2afd428a"}, {"audio": 0, "start": 1532906, "crunched": 0, "end": 1533714, "filename": "/.git/objects/0b/a0bf660b22ad097254cbeb0d9b45310a80327b"}, {"audio": 0, "start": 1533714, "crunched": 0, "end": 1535115, "filename": "/.git/objects/0d/da5b31784b0774c5004f63d2cfc12d73c0ef21"}, {"audio": 0, "start": 1535115, "crunched": 0, "end": 1535451, "filename": "/.git/objects/0e/967403c9a7713ebcd2c8a81e6fd4de07a42d9b"}, {"audio": 0, "start": 1535451, "crunched": 0, "end": 1535902, "filename": "/.git/objects/0f/264e147bf34e9560f84e39ef29ce3661ee1608"}, {"audio": 0, "start": 1535902, "crunched": 0, "end": 1536064, "filename": "/.git/objects/0f/d54049a48366fc9c1f20cbba0423eddb365cb7"}, {"audio": 0, "start": 1536064, "crunched": 0, "end": 1536256, "filename": "/.git/objects/10/943aaed42adbe77d62d9073ed445f53a09f45f"}, {"audio": 0, "start": 1536256, "crunched": 0, "end": 1536430, "filename": "/.git/objects/10/ceb0c351b0f874aef1344f513cd8e24b59a28c"}, {"audio": 0, "start": 1536430, "crunched": 0, "end": 1536708, "filename": "/.git/objects/11/2514d36e93c85b5e456f62e2299ab37614ea79"}, {"audio": 0, "start": 1536708, "crunched": 0, "end": 1537061, "filename": "/.git/objects/12/52b07c428d1ad27dabd8e34b0e9037eb546924"}, {"audio": 0, "start": 1537061, "crunched": 0, "end": 1537246, "filename": "/.git/objects/12/b9705365c6305e37a600f115f9892f48c8ed97"}, {"audio": 0, "start": 1537246, "crunched": 0, "end": 1537417, "filename": "/.git/objects/13/0c0669624affadc62254219c9a2d0b5d045669"}, {"audio": 0, "start": 1537417, "crunched": 0, "end": 1537612, "filename": "/.git/objects/14/464d43ef1384f2209a6ea2390d73000847fc51"}, {"audio": 0, "start": 1537612, "crunched": 0, "end": 1538064, "filename": "/.git/objects/14/b85e9dbad5ead62c0a98b591db24b863338333"}, {"audio": 0, "start": 1538064, "crunched": 0, "end": 1538964, "filename": "/.git/objects/15/028dd6d39decf7363abb9b011929010d34b326"}, {"audio": 0, "start": 1538964, "crunched": 0, "end": 1540263, "filename": "/.git/objects/15/393cca1b6d7801c8adb08db413d29053bdeedc"}, {"audio": 0, "start": 1540263, "crunched": 0, "end": 1540715, "filename": "/.git/objects/15/678a7f45ab98285b4faa8a90fd62ca7a22e75e"}, {"audio": 0, "start": 1540715, "crunched": 0, "end": 1541128, "filename": "/.git/objects/16/8371570469057c5fac84d0dc88572d925830c0"}, {"audio": 0, "start": 1541128, "crunched": 0, "end": 1542354, "filename": "/.git/objects/19/10823419e8d95f61f1e4fba861c0eff5fd4cf3"}, {"audio": 0, "start": 1542354, "crunched": 0, "end": 1542609, "filename": "/.git/objects/1c/435db03459fc918e66bfe7919ccfc6e0efaed7"}, {"audio": 0, "start": 1542609, "crunched": 0, "end": 1543743, "filename": "/.git/objects/1c/fd6dd058772671cb6ee3d0b70bac178f51fa82"}, {"audio": 0, "start": 1543743, "crunched": 0, "end": 1543801, "filename": "/.git/objects/1f/0ab3850709b60f0b0ffe6896c1b613ae94dbf1"}, {"audio": 0, "start": 1543801, "crunched": 0, "end": 1543978, "filename": "/.git/objects/1f/7cbdb65ce9222f9c226b8e91cd0b300b114a08"}, {"audio": 0, "start": 1543978, "crunched": 0, "end": 1545271, "filename": "/.git/objects/1f/ac98444e279e1aca925f49d367d6995ea241c4"}, {"audio": 0, "start": 1545271, "crunched": 0, "end": 1545684, "filename": "/.git/objects/1f/f70f8ebe8b372213e03c92d5a2aa7ca5776911"}, {"audio": 0, "start": 1545684, "crunched": 0, "end": 1548971, "filename": "/.git/objects/20/77428395d2609045b931e24951cf92131b80b4"}, {"audio": 0, "start": 1548971, "crunched": 0, "end": 1549382, "filename": "/.git/objects/22/da2e44bf4f3cdba76274b2f0f1c9df39e268f9"}, {"audio": 0, "start": 1549382, "crunched": 0, "end": 1549671, "filename": "/.git/objects/27/b9c97575cd29d4d3f561661ab98472f8ef419e"}, {"audio": 0, "start": 1549671, "crunched": 0, "end": 1554584, "filename": "/.git/objects/29/c488115d9a0864f9fc6179eee7a0157c68792a"}, {"audio": 0, "start": 1554584, "crunched": 0, "end": 1558386, "filename": "/.git/objects/2b/d4641295a50e3eb1a8b7223af3869cd837e191"}, {"audio": 0, "start": 1558386, "crunched": 0, "end": 1559462, "filename": "/.git/objects/2c/07fc43432e30887bb8df0717e4ffd35fb3c716"}, {"audio": 0, "start": 1559462, "crunched": 0, "end": 1559837, "filename": "/.git/objects/2e/098d73d0b640f001c626d9ca7f51ae149f2119"}, {"audio": 0, "start": 1559837, "crunched": 0, "end": 1560099, "filename": "/.git/objects/2e/2778c9b41c39b4c91c77fd91ce26a343e03ec5"}, {"audio": 0, "start": 1560099, "crunched": 0, "end": 1560184, "filename": "/.git/objects/2e/8eb2cf5c42a27901ad6ce47ad2399cc3a0c7e3"}, {"audio": 0, "start": 1560184, "crunched": 0, "end": 1560361, "filename": "/.git/objects/31/05add5b4121cba7c6e6b398a832529bc9624ff"}, {"audio": 0, "start": 1560361, "crunched": 0, "end": 1560683, "filename": "/.git/objects/35/45da99c64a07da483395273e9aae4b952ac1a3"}, {"audio": 0, "start": 1560683, "crunched": 0, "end": 1564425, "filename": "/.git/objects/35/de595af08c831149e67153d67110a02ee989ab"}, {"audio": 0, "start": 1564425, "crunched": 0, "end": 1564636, "filename": "/.git/objects/36/3d57628b9a39488811c9da750db25e0732eee0"}, {"audio": 0, "start": 1564636, "crunched": 0, "end": 1566039, "filename": "/.git/objects/36/53abd605e616a5436cdc9b634a47bcd3723b1b"}, {"audio": 0, "start": 1566039, "crunched": 0, "end": 1566435, "filename": "/.git/objects/36/b03274926fbe660f98c7168bb8017046aa64ba"}, {"audio": 0, "start": 1566435, "crunched": 0, "end": 1568998, "filename": "/.git/objects/37/2fc5a992eadfa1a64b9f75d3d4bf1d43c682b1"}, {"audio": 0, "start": 1568998, "crunched": 0, "end": 1569303, "filename": "/.git/objects/37/56f0d05937b5972df360f5a00e7340f204556f"}, {"audio": 0, "start": 1569303, "crunched": 0, "end": 1570635, "filename": "/.git/objects/37/7316a2ca1ce98b95ef96b8945f032f6ebcd6ae"}, {"audio": 0, "start": 1570635, "crunched": 0, "end": 1572368, "filename": "/.git/objects/38/ea7ee9340ee6aeabd2a396030771e2473f1dc9"}, {"audio": 0, "start": 1572368, "crunched": 0, "end": 1572697, "filename": "/.git/objects/39/b6fbf456ca6b836d6a613da2362a193458422e"}, {"audio": 0, "start": 1572697, "crunched": 0, "end": 1572782, "filename": "/.git/objects/3a/3b84558ec6a0e9f6c736c4f16bcb2be13b9479"}, {"audio": 0, "start": 1572782, "crunched": 0, "end": 1572870, "filename": "/.git/objects/3a/a449d8a644822683502a66eb1d8229b0a7093a"}, {"audio": 0, "start": 1572870, "crunched": 0, "end": 1573458, "filename": "/.git/objects/3b/086aa8a9a9f2893768b6f0319bf34b78abbc9a"}, {"audio": 0, "start": 1573458, "crunched": 0, "end": 1573628, "filename": "/.git/objects/3b/13b1a4cc8d6cd6ba14d9d7b74d26c3e0020c7b"}, {"audio": 0, "start": 1573628, "crunched": 0, "end": 1577228, "filename": "/.git/objects/3b/271c210eab6db43207b70ee0f9818174dfb32b"}, {"audio": 0, "start": 1577228, "crunched": 0, "end": 1577642, "filename": "/.git/objects/3c/3c10f44c468e8ff7b27e8a88d1e2df74ebae02"}, {"audio": 0, "start": 1577642, "crunched": 0, "end": 1581213, "filename": "/.git/objects/3c/95828aaf09377c20ecab5696314d9a0675db8b"}, {"audio": 0, "start": 1581213, "crunched": 0, "end": 1581605, "filename": "/.git/objects/3e/4b0541de467f869f4b1ba2803dbfaa076a6c0e"}, {"audio": 0, "start": 1581605, "crunched": 0, "end": 1581808, "filename": "/.git/objects/3f/563f51f7488c530743233a7ef37904532eccf0"}, {"audio": 0, "start": 1581808, "crunched": 0, "end": 1582247, "filename": "/.git/objects/3f/aa0405c8da87d414f4ba135094a78abe27ace3"}, {"audio": 0, "start": 1582247, "crunched": 0, "end": 1582643, "filename": "/.git/objects/3f/b3d0f0f1e8a5d1f7c0840ab16c9ce5f01f97d1"}, {"audio": 0, "start": 1582643, "crunched": 0, "end": 1582932, "filename": "/.git/objects/40/29361e0e0fe5351c942c71ad6dce466c7286a0"}, {"audio": 0, "start": 1582932, "crunched": 0, "end": 1583195, "filename": "/.git/objects/41/7da4da63f75a7c94dd521305e3f49399c42a6f"}, {"audio": 0, "start": 1583195, "crunched": 0, "end": 1583411, "filename": "/.git/objects/43/8c085aa91927cc81bfed049b3fae6ed770c736"}, {"audio": 0, "start": 1583411, "crunched": 0, "end": 1583530, "filename": "/.git/objects/43/a3b7e444d7fa55109c0fc84d733e407c48d480"}, {"audio": 0, "start": 1583530, "crunched": 0, "end": 1584480, "filename": "/.git/objects/46/0800c821c2ecdf3baeae771a2d6f0bc3b083ad"}, {"audio": 0, "start": 1584480, "crunched": 0, "end": 1584671, "filename": "/.git/objects/47/a9e6b0174f6865f69206bd862c3279eb9f5f0d"}, {"audio": 0, "start": 1584671, "crunched": 0, "end": 1585125, "filename": "/.git/objects/48/4849a4a0b5b7fae400703e0ef43ebe6510845c"}, {"audio": 0, "start": 1585125, "crunched": 0, "end": 1586804, "filename": "/.git/objects/4a/42205ec54c6052e3b7fb55282b321bc0db46ef"}, {"audio": 0, "start": 1586804, "crunched": 0, "end": 1586981, "filename": "/.git/objects/4b/0af5bc16cf64c09ec856480e5ffaa0e14df859"}, {"audio": 0, "start": 1586981, "crunched": 0, "end": 1587158, "filename": "/.git/objects/4b/26864cea130382da2970e593bfcaf40ce1d951"}, {"audio": 0, "start": 1587158, "crunched": 0, "end": 1587533, "filename": "/.git/objects/4c/3e06678d9134a7b3e94b2f0162ee5da509868a"}, {"audio": 0, "start": 1587533, "crunched": 0, "end": 1587795, "filename": "/.git/objects/4c/3f0cdeb0e7f5fb0389dadc42710a9aa885270f"}, {"audio": 0, "start": 1587795, "crunched": 0, "end": 1587874, "filename": "/.git/objects/4e/b3bd1ba865eb1c16d68cdb4d27f79443533037"}, {"audio": 0, "start": 1587874, "crunched": 0, "end": 1588120, "filename": "/.git/objects/4f/02d72f77d5e584a02b8fe619bbbbb768ae62c5"}, {"audio": 0, "start": 1588120, "crunched": 0, "end": 1588411, "filename": "/.git/objects/4f/1634ea858200fd8615392106bbe2d39fda7e8b"}, {"audio": 0, "start": 1588411, "crunched": 0, "end": 1588807, "filename": "/.git/objects/4f/93f4b7bcbb6e65dfe77720e56c4f0b46cfd3e3"}, {"audio": 0, "start": 1588807, "crunched": 0, "end": 1589166, "filename": "/.git/objects/51/5e62e75a9a4782b1e676a2ad3e73103de755d6"}, {"audio": 0, "start": 1589166, "crunched": 0, "end": 1589370, "filename": "/.git/objects/52/5ea573ea8db5573ca59d3c93debe39598035a8"}, {"audio": 0, "start": 1589370, "crunched": 0, "end": 1589748, "filename": "/.git/objects/55/dc3cf6936725876a468b001b4531fa369c606e"}, {"audio": 0, "start": 1589748, "crunched": 0, "end": 1589958, "filename": "/.git/objects/56/07828d29471792bb770c08412232635e3cccff"}, {"audio": 0, "start": 1589958, "crunched": 0, "end": 1590371, "filename": "/.git/objects/56/29681d2fbec1cb34cf86d1c052f2cd2bf210ab"}, {"audio": 0, "start": 1590371, "crunched": 0, "end": 1591677, "filename": "/.git/objects/56/45cbbde6c08ff06d90d1d57a7628e913018a64"}, {"audio": 0, "start": 1591677, "crunched": 0, "end": 1592076, "filename": "/.git/objects/56/6b01098ec9cf568728bec3fc40b6ac19474953"}, {"audio": 0, "start": 1592076, "crunched": 0, "end": 1592375, "filename": "/.git/objects/56/ae7f91363857198a88a593172d64a1eabf2dbe"}, {"audio": 0, "start": 1592375, "crunched": 0, "end": 1597293, "filename": "/.git/objects/56/cd3255f8354ed671bdb807d58c5a7c36c28c2b"}, {"audio": 0, "start": 1597293, "crunched": 0, "end": 1597486, "filename": "/.git/objects/57/21d06457d8a701b376f80ce6d6f6936772844d"}, {"audio": 0, "start": 1597486, "crunched": 0, "end": 1599839, "filename": "/.git/objects/57/7242d695d2f8f638cefafcc996b793edf20bc0"}, {"audio": 0, "start": 1599839, "crunched": 0, "end": 1599927, "filename": "/.git/objects/57/8c262dad2993e6a11da5c1ccee0b445783ddb8"}, {"audio": 0, "start": 1599927, "crunched": 0, "end": 1600226, "filename": "/.git/objects/5a/071c409bd16d05479f6c8e9cf2ac940002f880"}, {"audio": 0, "start": 1600226, "crunched": 0, "end": 1600574, "filename": "/.git/objects/5c/103679e0644a47a2f8ae967e245a322d425d39"}, {"audio": 0, "start": 1600574, "crunched": 0, "end": 1601974, "filename": "/.git/objects/5c/abc7b671ca6bccc3e9b44ca469a5277e17c833"}, {"audio": 0, "start": 1601974, "crunched": 0, "end": 1602179, "filename": "/.git/objects/5d/5b6a332e2f16ea583ebfae33d5406bfa3e1384"}, {"audio": 0, "start": 1602179, "crunched": 0, "end": 1602467, "filename": "/.git/objects/5d/e2bd125dc52131325a9e9e8719af44d7e1e39a"}, {"audio": 0, "start": 1602467, "crunched": 0, "end": 1604201, "filename": "/.git/objects/5e/bc50f6d874a01812fb483a5e15c7538f725e2d"}, {"audio": 0, "start": 1604201, "crunched": 0, "end": 1604613, "filename": "/.git/objects/5f/f2567067b8d58d559e31673a37b25ab3842c30"}, {"audio": 0, "start": 1604613, "crunched": 0, "end": 1604724, "filename": "/.git/objects/60/00a5a066497c2df727f36b7fc9d8c0a1610f7c"}, {"audio": 0, "start": 1604724, "crunched": 0, "end": 1606037, "filename": "/.git/objects/60/870d7532966a2799fa8aab43869b4c09d38dad"}, {"audio": 0, "start": 1606037, "crunched": 0, "end": 1606265, "filename": "/.git/objects/61/33e4356bb4736d4d7db121632b63f212eb77a0"}, {"audio": 0, "start": 1606265, "crunched": 0, "end": 1606477, "filename": "/.git/objects/61/6785498f0b7f5618791a9e7536159bae8898b4"}, {"audio": 0, "start": 1606477, "crunched": 0, "end": 1606688, "filename": "/.git/objects/61/88700159712aa34d06dc589203f46c87dd23c5"}, {"audio": 0, "start": 1606688, "crunched": 0, "end": 1606882, "filename": "/.git/objects/63/6d03cac8df1da02a8e0681083b2079ea6fa125"}, {"audio": 0, "start": 1606882, "crunched": 0, "end": 1607113, "filename": "/.git/objects/65/1c009556cd2ec003911a169c0cb6d720204ed3"}, {"audio": 0, "start": 1607113, "crunched": 0, "end": 1607586, "filename": "/.git/objects/65/73dddea015e8777b73dbb41c31591f2320556f"}, {"audio": 0, "start": 1607586, "crunched": 0, "end": 1608959, "filename": "/.git/objects/66/62510d207c1aa29c797ab2cc8290fb38dac1cd"}, {"audio": 0, "start": 1608959, "crunched": 0, "end": 1609249, "filename": "/.git/objects/66/7ab7854a66320a6c7696495c09894db3585c3d"}, {"audio": 0, "start": 1609249, "crunched": 0, "end": 1609661, "filename": "/.git/objects/66/cc54e8c11cee4d2c9b6744ed73129ce2c19056"}, {"audio": 0, "start": 1609661, "crunched": 0, "end": 1610958, "filename": "/.git/objects/67/23f11f2761a6a95975eb5864158eadc416de4a"}, {"audio": 0, "start": 1610958, "crunched": 0, "end": 1611701, "filename": "/.git/objects/68/13ce0b4805bd9332e427f568f917903d16a2b3"}, {"audio": 0, "start": 1611701, "crunched": 0, "end": 1611898, "filename": "/.git/objects/68/cbcb73bc93d80f08b5f77f34f9a8a4a77136f6"}, {"audio": 0, "start": 1611898, "crunched": 0, "end": 1611986, "filename": "/.git/objects/69/2cba7af97b221c93e9249dbf4146e10720d98a"}, {"audio": 0, "start": 1611986, "crunched": 0, "end": 1612399, "filename": "/.git/objects/69/dfff488e0e63d6d9946afdcc968a157e24983e"}, {"audio": 0, "start": 1612399, "crunched": 0, "end": 1612605, "filename": "/.git/objects/6b/e8b7268d9a72939b17ce5151ec6c5a29bc3b5c"}, {"audio": 0, "start": 1612605, "crunched": 0, "end": 1613126, "filename": "/.git/objects/6d/6a3d14212d7b9aec75e3545c4b8b331d6ad033"}, {"audio": 0, "start": 1613126, "crunched": 0, "end": 1613449, "filename": "/.git/objects/6d/8a40c5fd8b8ed39f4a1ab15985075df106d41a"}, {"audio": 0, "start": 1613449, "crunched": 0, "end": 1613862, "filename": "/.git/objects/6e/2cef21148fa65cc1de31e9dfa683039533385d"}, {"audio": 0, "start": 1613862, "crunched": 0, "end": 1614152, "filename": "/.git/objects/6f/8b64ea1d6cf80adbf5e3421af099cf20d1ec8d"}, {"audio": 0, "start": 1614152, "crunched": 0, "end": 1614521, "filename": "/.git/objects/72/6573ae45aa2a3e1101fe6fdd593fd7fc9db443"}, {"audio": 0, "start": 1614521, "crunched": 0, "end": 1614750, "filename": "/.git/objects/73/a84fa14c78ee849156c64be25f292f16921557"}, {"audio": 0, "start": 1614750, "crunched": 0, "end": 1616478, "filename": "/.git/objects/74/4f55109f0ba3b51c733e42d153c7edcdd3a1b2"}, {"audio": 0, "start": 1616478, "crunched": 0, "end": 1616654, "filename": "/.git/objects/74/6ff74e77350df6caf8c6c8f077eb5e9465deec"}, {"audio": 0, "start": 1616654, "crunched": 0, "end": 1619223, "filename": "/.git/objects/75/338198ad566b4a22c6ff76625f4cf870c1b004"}, {"audio": 0, "start": 1619223, "crunched": 0, "end": 1620986, "filename": "/.git/objects/75/850df53c713b8a5e344a253a35040d47c2fd07"}, {"audio": 0, "start": 1620986, "crunched": 0, "end": 1621162, "filename": "/.git/objects/76/fbc17525245e428a2f54c79fcc6955b5c3977a"}, {"audio": 0, "start": 1621162, "crunched": 0, "end": 1621576, "filename": "/.git/objects/77/ae9e3d8d5caf651fa010cfc08a23d387aa7c07"}, {"audio": 0, "start": 1621576, "crunched": 0, "end": 1621982, "filename": "/.git/objects/78/652d7144de742ef62f2550aca2822b76de5783"}, {"audio": 0, "start": 1621982, "crunched": 0, "end": 1622394, "filename": "/.git/objects/78/b7a4d360123c1899f9acf538c4d52f75de0404"}, {"audio": 0, "start": 1622394, "crunched": 0, "end": 1625548, "filename": "/.git/objects/79/4cac0774725ab300825b2bd76ee329ad937a01"}, {"audio": 0, "start": 1625548, "crunched": 0, "end": 1625896, "filename": "/.git/objects/7a/00955f08c7f633f2466295a9b760d5840d26f0"}, {"audio": 0, "start": 1625896, "crunched": 0, "end": 1627635, "filename": "/.git/objects/7a/8d834d1d29130554ecf72d0707bbdb3316636f"}, {"audio": 0, "start": 1627635, "crunched": 0, "end": 1627899, "filename": "/.git/objects/7d/a87065114754c6948e743858a9a9296b17e920"}, {"audio": 0, "start": 1627899, "crunched": 0, "end": 1630365, "filename": "/.git/objects/7e/8569e6ea7c0c6bc79cc3cb02d9965a019d2ed2"}, {"audio": 0, "start": 1630365, "crunched": 0, "end": 1632099, "filename": "/.git/objects/7e/f6c10318cd699350fac5891fdb258abf8d81f6"}, {"audio": 0, "start": 1632099, "crunched": 0, "end": 1632578, "filename": "/.git/objects/80/f0b7d4de0a20afc39f58e756a76900a4d90bc8"}, {"audio": 0, "start": 1632578, "crunched": 0, "end": 1633999, "filename": "/.git/objects/81/36d1879eb351e171bd92aa0881bc42fc5940d9"}, {"audio": 0, "start": 1633999, "crunched": 0, "end": 1634962, "filename": "/.git/objects/81/af1a99a60af003275a4d49d6814dca051ac98d"}, {"audio": 0, "start": 1634962, "crunched": 0, "end": 1635140, "filename": "/.git/objects/81/c2c3fba5426b840f5659ce9fe1f8f2fdf77c05"}, {"audio": 0, "start": 1635140, "crunched": 0, "end": 1635317, "filename": "/.git/objects/82/e98c7c420547e6639876303058ef8c04d5c6f5"}, {"audio": 0, "start": 1635317, "crunched": 0, "end": 1635617, "filename": "/.git/objects/83/e56b189483113ed451be12a717b2c145429ea7"}, {"audio": 0, "start": 1635617, "crunched": 0, "end": 1637018, "filename": "/.git/objects/84/5b491d161d5d0c817386a748e3a3bfc310a2ad"}, {"audio": 0, "start": 1637018, "crunched": 0, "end": 1638966, "filename": "/.git/objects/86/1d40c3da583833715fe41eb34c49a6ae28318d"}, {"audio": 0, "start": 1638966, "crunched": 0, "end": 1639255, "filename": "/.git/objects/87/b78c71998b11addd93627b5cc73b67657d4dea"}, {"audio": 0, "start": 1639255, "crunched": 0, "end": 1639343, "filename": "/.git/objects/88/ec1268e0da8ca10dd0c57232714207be937087"}, {"audio": 0, "start": 1639343, "crunched": 0, "end": 1639942, "filename": "/.git/objects/8c/8b6367f544860a7e6b8d1654848552fbf48666"}, {"audio": 0, "start": 1639942, "crunched": 0, "end": 1640338, "filename": "/.git/objects/90/766b9cd79adae3575e4fca564baf0c75d0e274"}, {"audio": 0, "start": 1640338, "crunched": 0, "end": 1640536, "filename": "/.git/objects/94/b8e53a7938554cb4beed742473c1c671fa0947"}, {"audio": 0, "start": 1640536, "crunched": 0, "end": 1640839, "filename": "/.git/objects/95/b84f2e871ecb930c2d0e1fff756d9497fd9923"}, {"audio": 0, "start": 1640839, "crunched": 0, "end": 1640962, "filename": "/.git/objects/95/febce4fda2e9436751ba50e3885507ad5af10b"}, {"audio": 0, "start": 1640962, "crunched": 0, "end": 1642697, "filename": "/.git/objects/97/461dec29baa39ee9ef94be5ef3d49128f25245"}, {"audio": 0, "start": 1642697, "crunched": 0, "end": 1643080, "filename": "/.git/objects/97/ab1ed6ef663ca8fb8030060da64d1ac59c3654"}, {"audio": 0, "start": 1643080, "crunched": 0, "end": 1643138, "filename": "/.git/objects/98/e73d4ed41da26c8ce126bc55d2d78675b613ba"}, {"audio": 0, "start": 1643138, "crunched": 0, "end": 1643308, "filename": "/.git/objects/99/1cd6d68b4c61cd3836a83700d6788dd3efdc53"}, {"audio": 0, "start": 1643308, "crunched": 0, "end": 1644613, "filename": "/.git/objects/99/43d1d4f641b91d0afbd00f5f2e0a827eeceb21"}, {"audio": 0, "start": 1644613, "crunched": 0, "end": 1644993, "filename": "/.git/objects/9a/5e5a19beb48aea4a3f9d0557a5f6a4016a8c11"}, {"audio": 0, "start": 1644993, "crunched": 0, "end": 1645405, "filename": "/.git/objects/9b/2e409dcc899fa4e8a6cf7bfdbf1594c654915d"}, {"audio": 0, "start": 1645405, "crunched": 0, "end": 1645846, "filename": "/.git/objects/9e/6375bc6c4479cdecd08f227fbb0467659b99b4"}, {"audio": 0, "start": 1645846, "crunched": 0, "end": 1646141, "filename": "/.git/objects/9e/7f4930a2b90ded9fef53aa8bebfd6aca664c2b"}, {"audio": 0, "start": 1646141, "crunched": 0, "end": 1646606, "filename": "/.git/objects/9f/1ffd1c44135b662218306e19987a5b4db01aa2"}, {"audio": 0, "start": 1646606, "crunched": 0, "end": 1647946, "filename": "/.git/objects/9f/aca2eafae1e0d8126d72ef20ade7720191aeb5"}, {"audio": 0, "start": 1647946, "crunched": 0, "end": 1652853, "filename": "/.git/objects/a0/26536aabe2eb2b84e14fa0473b452a6cbbef89"}, {"audio": 0, "start": 1652853, "crunched": 0, "end": 1653151, "filename": "/.git/objects/a1/caa802656e6f8d6f719155ee3128efa3cbfcf6"}, {"audio": 0, "start": 1653151, "crunched": 0, "end": 1653265, "filename": "/.git/objects/a1/e6b6203aa921bfe3d08d4264648b48b5171adc"}, {"audio": 0, "start": 1653265, "crunched": 0, "end": 1655843, "filename": "/.git/objects/a2/a537b22f5e5751b4224afddc1ec3b6d3cb7fef"}, {"audio": 0, "start": 1655843, "crunched": 0, "end": 1657436, "filename": "/.git/objects/a3/8c9da64eb299265fa1e78d8c60dba93d3999ef"}, {"audio": 0, "start": 1657436, "crunched": 0, "end": 1657763, "filename": "/.git/objects/a3/d5a99ef057b141751073e80c3236bfebb67b5f"}, {"audio": 0, "start": 1657763, "crunched": 0, "end": 1657944, "filename": "/.git/objects/a5/e27042fc5f1e7871ce872d25a1f646ed36a059"}, {"audio": 0, "start": 1657944, "crunched": 0, "end": 1659241, "filename": "/.git/objects/a8/983733f6f720e6e8347182a8ee71faffeff62f"}, {"audio": 0, "start": 1659241, "crunched": 0, "end": 1659453, "filename": "/.git/objects/a8/d6efa43c61b34d87fcbc0bbdf5e49c03e0cfe8"}, {"audio": 0, "start": 1659453, "crunched": 0, "end": 1660259, "filename": "/.git/objects/a9/e2a6d85997a2b3cd9bd9ba2d7a3635a84fe2c0"}, {"audio": 0, "start": 1660259, "crunched": 0, "end": 1660317, "filename": "/.git/objects/aa/23af1951328aed2a0b44b914de01fbb2af132c"}, {"audio": 0, "start": 1660317, "crunched": 0, "end": 1660742, "filename": "/.git/objects/ab/9b2869dd508fba733e1bb50376bd8e9367b446"}, {"audio": 0, "start": 1660742, "crunched": 0, "end": 1661060, "filename": "/.git/objects/ac/557c9bf7a49020c402347bd82be550c03f9093"}, {"audio": 0, "start": 1661060, "crunched": 0, "end": 1661232, "filename": "/.git/objects/ae/3627bdb36b83d1e25f23c2eb0d7d86695b9c7d"}, {"audio": 0, "start": 1661232, "crunched": 0, "end": 1661431, "filename": "/.git/objects/ae/5a414eb97109416786eacb68fe704823474b49"}, {"audio": 0, "start": 1661431, "crunched": 0, "end": 1661721, "filename": "/.git/objects/af/564b70d29928277c69877eb7ff511cba3442a8"}, {"audio": 0, "start": 1661721, "crunched": 0, "end": 1663705, "filename": "/.git/objects/af/8412475b569a05e4af54982af4538cca2dcf9c"}, {"audio": 0, "start": 1663705, "crunched": 0, "end": 1664295, "filename": "/.git/objects/b0/959163c9835cc59892bc4f7e9c0bd21dbfc127"}, {"audio": 0, "start": 1664295, "crunched": 0, "end": 1664486, "filename": "/.git/objects/b1/375a3ade70111ed6dd8b45e6cc2a868d814138"}, {"audio": 0, "start": 1664486, "crunched": 0, "end": 1664787, "filename": "/.git/objects/b1/c7c88ab7d9bfb1c0f49dcf270546d841af91b0"}, {"audio": 0, "start": 1664787, "crunched": 0, "end": 1665200, "filename": "/.git/objects/b2/5402934ad8214ee2b2dd2d0aed50b9a1ff80de"}, {"audio": 0, "start": 1665200, "crunched": 0, "end": 1665410, "filename": "/.git/objects/b5/083e461dde6472bbcbdc72526e89e4af4a46fc"}, {"audio": 0, "start": 1665410, "crunched": 0, "end": 1665732, "filename": "/.git/objects/b5/b69c90cdf43385e144076c5577ea632a173d69"}, {"audio": 0, "start": 1665732, "crunched": 0, "end": 1665942, "filename": "/.git/objects/b6/79d7b4b315398d211d61c61f92e49133ee3d95"}, {"audio": 0, "start": 1665942, "crunched": 0, "end": 1666333, "filename": "/.git/objects/b6/849930132562d53abc1431d27624f234e66c98"}, {"audio": 0, "start": 1666333, "crunched": 0, "end": 1666544, "filename": "/.git/objects/b7/10e0bbaa61e878c9d1207114a83dfc3414da42"}, {"audio": 0, "start": 1666544, "crunched": 0, "end": 1666756, "filename": "/.git/objects/b7/d69d9ed9877257fad7f4799bfd46c824b5b476"}, {"audio": 0, "start": 1666756, "crunched": 0, "end": 1667152, "filename": "/.git/objects/ba/88f4eb5d4cc8692fff712eb9e5df06f96a3238"}, {"audio": 0, "start": 1667152, "crunched": 0, "end": 1667450, "filename": "/.git/objects/bc/4ac7d3425ca7994170a05525c67fa5865e0cee"}, {"audio": 0, "start": 1667450, "crunched": 0, "end": 1668156, "filename": "/.git/objects/bc/60ee686b345fc2bc60991447dbcf80de2081c9"}, {"audio": 0, "start": 1668156, "crunched": 0, "end": 1668322, "filename": "/.git/objects/bc/ec6e4674b4e50fb3104fa69ee57b30bf35fb94"}, {"audio": 0, "start": 1668322, "crunched": 0, "end": 1668876, "filename": "/.git/objects/bd/0e5fafc470b7039a316239676fb0eb3a8798f3"}, {"audio": 0, "start": 1668876, "crunched": 0, "end": 1669579, "filename": "/.git/objects/be/1e5081153051e0f4503a5dda597ab6b0cc0068"}, {"audio": 0, "start": 1669579, "crunched": 0, "end": 1671351, "filename": "/.git/objects/c0/2e4f9c9080e323b775b30c292b052b5728c205"}, {"audio": 0, "start": 1671351, "crunched": 0, "end": 1671464, "filename": "/.git/objects/c0/cf7729abf64b2554e6df59950ce925a5c79493"}, {"audio": 0, "start": 1671464, "crunched": 0, "end": 1672005, "filename": "/.git/objects/c1/90a20e18463e0a861a3ddff4b247a46cf97080"}, {"audio": 0, "start": 1672005, "crunched": 0, "end": 1675384, "filename": "/.git/objects/c2/6b6bec9a7b39a5b397fffe0cdaccc16341a88a"}, {"audio": 0, "start": 1675384, "crunched": 0, "end": 1675739, "filename": "/.git/objects/c2/c792dda8c101a267e9ac9d6ed9b0dba5664219"}, {"audio": 0, "start": 1675739, "crunched": 0, "end": 1678613, "filename": "/.git/objects/c2/fbfe0acaa71de0a8934cd1cab548b754ad1898"}, {"audio": 0, "start": 1678613, "crunched": 0, "end": 1678736, "filename": "/.git/objects/c3/4302b59b31455771b37a7c4f51cadef52ccf88"}, {"audio": 0, "start": 1678736, "crunched": 0, "end": 1682903, "filename": "/.git/objects/c7/112cd2eece2322ad4aacc7fbb31a1c4e32fef6"}, {"audio": 0, "start": 1682903, "crunched": 0, "end": 1683603, "filename": "/.git/objects/c9/4836d7d03e17bcaef9831a4b6cb6f6d7132ebb"}, {"audio": 0, "start": 1683603, "crunched": 0, "end": 1683798, "filename": "/.git/objects/ca/06738abd6b489a88243fc4474d6265df5a3ddc"}, {"audio": 0, "start": 1683798, "crunched": 0, "end": 1684001, "filename": "/.git/objects/ca/3f512a1576247f72f9b5dea7366a6c09a4e1cf"}, {"audio": 0, "start": 1684001, "crunched": 0, "end": 1684141, "filename": "/.git/objects/cb/768cf081107cf0ef8753773bc962524bab2ce5"}, {"audio": 0, "start": 1684141, "crunched": 0, "end": 1684997, "filename": "/.git/objects/cf/65330e3712c2a30c8746d5db87f1d658b649a4"}, {"audio": 0, "start": 1684997, "crunched": 0, "end": 1685492, "filename": "/.git/objects/d0/302592d11c1c58bc28b8eee43ad818c2172b0e"}, {"audio": 0, "start": 1685492, "crunched": 0, "end": 1685577, "filename": "/.git/objects/d0/b40844b44b1de4f9a0748575dab7e83713d47d"}, {"audio": 0, "start": 1685577, "crunched": 0, "end": 1685908, "filename": "/.git/objects/d1/10513e476b98eee954ce5779f9279a8172fe4e"}, {"audio": 0, "start": 1685908, "crunched": 0, "end": 1686096, "filename": "/.git/objects/d1/edd5979be5a0c0f2cddcb0e9eccd0f2b555ad3"}, {"audio": 0, "start": 1686096, "crunched": 0, "end": 1686400, "filename": "/.git/objects/d1/f486b981232a2f03c0e8e83aa08e21bb6b2296"}, {"audio": 0, "start": 1686400, "crunched": 0, "end": 1686796, "filename": "/.git/objects/d3/cb4c6a8e5ac0d83b55dfa12b38d6a4aa35178d"}, {"audio": 0, "start": 1686796, "crunched": 0, "end": 1686963, "filename": "/.git/objects/d4/4edc3fb4aeec19cdaf7f51470149c984843b5e"}, {"audio": 0, "start": 1686963, "crunched": 0, "end": 1688293, "filename": "/.git/objects/d4/af7a3f0f2988fc046957645f11e9da9de199d5"}, {"audio": 0, "start": 1688293, "crunched": 0, "end": 1688663, "filename": "/.git/objects/d5/5f81d87d84001dc0daa393b34a76385625872b"}, {"audio": 0, "start": 1688663, "crunched": 0, "end": 1688922, "filename": "/.git/objects/d6/9ef5a2ca5c751dd7cd01dbae07f1cc034f1498"}, {"audio": 0, "start": 1688922, "crunched": 0, "end": 1689103, "filename": "/.git/objects/d7/06fcdfc5ce2d8e1d36dfbb89022d8db8920b8a"}, {"audio": 0, "start": 1689103, "crunched": 0, "end": 1689657, "filename": "/.git/objects/d9/5b19197ae0ff773ac43def875888d4f86dc99f"}, {"audio": 0, "start": 1689657, "crunched": 0, "end": 1689741, "filename": "/.git/objects/d9/c139f0af44b07bede6cc027432ddaa83a25bcc"}, {"audio": 0, "start": 1689741, "crunched": 0, "end": 1690146, "filename": "/.git/objects/da/130a7a157a2a0349776db1b3489af2ba267e50"}, {"audio": 0, "start": 1690146, "crunched": 0, "end": 1690736, "filename": "/.git/objects/da/237cb2217dbafe06e84e819c10e31ffdff5536"}, {"audio": 0, "start": 1690736, "crunched": 0, "end": 1692040, "filename": "/.git/objects/da/497a49dce45b3de0aa8971ec69230af6db7159"}, {"audio": 0, "start": 1692040, "crunched": 0, "end": 1692951, "filename": "/.git/objects/db/34f8d169b1575a5e5963731c703bc49e27bd80"}, {"audio": 0, "start": 1692951, "crunched": 0, "end": 1693249, "filename": "/.git/objects/e0/3502c23106ab4714e7f98cf28e5eea869ba4e3"}, {"audio": 0, "start": 1693249, "crunched": 0, "end": 1693635, "filename": "/.git/objects/e2/2e838fcb5378bed163626c884509d8a791edfe"}, {"audio": 0, "start": 1693635, "crunched": 0, "end": 1694940, "filename": "/.git/objects/e2/36a7dc29329d0bb9b62303de11c3e90cf7c75a"}, {"audio": 0, "start": 1694940, "crunched": 0, "end": 1695239, "filename": "/.git/objects/e2/e9328bf89e78b8c34fd4c41005b2e588e5f8b4"}, {"audio": 0, "start": 1695239, "crunched": 0, "end": 1695529, "filename": "/.git/objects/e4/c584664e91f03e76a794f8a46f6d0ef0f2f513"}, {"audio": 0, "start": 1695529, "crunched": 0, "end": 1697596, "filename": "/.git/objects/e6/cad2d256b4db3fd35b9290e8e0cb5d4781824b"}, {"audio": 0, "start": 1697596, "crunched": 0, "end": 1697773, "filename": "/.git/objects/e7/368e15ad406d6e448979f3012160cf13cbcf4e"}, {"audio": 0, "start": 1697773, "crunched": 0, "end": 1699769, "filename": "/.git/objects/e7/36b762ffeb8e89f23375c170e86d6e607f63d5"}, {"audio": 0, "start": 1699769, "crunched": 0, "end": 1703301, "filename": "/.git/objects/e7/f5631909dbc572aa366482f3f18197f5f9ea24"}, {"audio": 0, "start": 1703301, "crunched": 0, "end": 1705661, "filename": "/.git/objects/e8/0b4535df302394309caba818496fb566448c6a"}, {"audio": 0, "start": 1705661, "crunched": 0, "end": 1705749, "filename": "/.git/objects/e9/14356264f51ce5ed90c7234b79b5de41852220"}, {"audio": 0, "start": 1705749, "crunched": 0, "end": 1706012, "filename": "/.git/objects/e9/c3df948721ba7c9bf270689655adc75662653a"}, {"audio": 0, "start": 1706012, "crunched": 0, "end": 1706236, "filename": "/.git/objects/ea/32febe3cfb19fa6487592a3be600b2a9e1862e"}, {"audio": 0, "start": 1706236, "crunched": 0, "end": 1706464, "filename": "/.git/objects/ec/7ea8b0a8ddabead0f1f11ec47ee1598ef84c90"}, {"audio": 0, "start": 1706464, "crunched": 0, "end": 1706793, "filename": "/.git/objects/ee/317574b9deceec90da57a5c9873271e399ddea"}, {"audio": 0, "start": 1706793, "crunched": 0, "end": 1707101, "filename": "/.git/objects/ef/75aa7c016dd7d4a1ceed55bb58650f7c68846e"}, {"audio": 0, "start": 1707101, "crunched": 0, "end": 1708047, "filename": "/.git/objects/ef/ef5c145b96a4eda2abcb7d7f25e10051ed3bd9"}, {"audio": 0, "start": 1708047, "crunched": 0, "end": 1709340, "filename": "/.git/objects/f1/f979362c404d2334500a98056d2d38fceb525b"}, {"audio": 0, "start": 1709340, "crunched": 0, "end": 1709638, "filename": "/.git/objects/f4/1aca6576c2f59352ecf916b596e0eb717bb258"}, {"audio": 0, "start": 1709638, "crunched": 0, "end": 1711325, "filename": "/.git/objects/f4/8130eebaa5f569513dec0c868f870caabc2bd8"}, {"audio": 0, "start": 1711325, "crunched": 0, "end": 1712816, "filename": "/.git/objects/f5/067399f859649145a59a2753a248692f0cc4b5"}, {"audio": 0, "start": 1712816, "crunched": 0, "end": 1713924, "filename": "/.git/objects/f5/ae1c9f405025d1fe56b0e69f6c3e7e0979dc77"}, {"audio": 0, "start": 1713924, "crunched": 0, "end": 1715697, "filename": "/.git/objects/fa/7893f52d9565201d8892a46afbfe4c8f1fc79f"}, {"audio": 0, "start": 1715697, "crunched": 0, "end": 1715916, "filename": "/.git/objects/fb/3635b73ec070e6d17f2c4097bfc4eb0ae71ed0"}, {"audio": 0, "start": 1715916, "crunched": 0, "end": 1717248, "filename": "/.git/objects/fb/e079b88857f2c5e78244310d8076e39df18253"}, {"audio": 0, "start": 1717248, "crunched": 0, "end": 1717802, "filename": "/.git/objects/fb/e7b1da81a0ec4c6a07d70c957d8a6d9ce664c6"}, {"audio": 0, "start": 1717802, "crunched": 0, "end": 1717978, "filename": "/.git/objects/fc/cdfd875ff5deec9072c66172818b693a584bed"}, {"audio": 0, "start": 1717978, "crunched": 0, "end": 1718348, "filename": "/.git/objects/fc/ffe65bcdc69e8f25345970c5a6e5defd7bc885"}, {"audio": 0, "start": 1718348, "crunched": 0, "end": 1718570, "filename": "/.git/objects/fe/6ce65d3ba501c8ad1a0f5c6a44a810ba7c7d00"}, {"audio": 0, "start": 1718570, "crunched": 0, "end": 1722050, "filename": "/.git/objects/pack/pack-299f108d04204a5e4601cdc2827749519a22dd7c.idx"}, {"audio": 0, "start": 1722050, "crunched": 0, "end": 2299098, "filename": "/.git/objects/pack/pack-299f108d04204a5e4601cdc2827749519a22dd7c.pack"}, {"audio": 0, "start": 2299098, "crunched": 0, "end": 2299139, "filename": "/.git/refs/heads/master"}, {"audio": 0, "start": 2299139, "crunched": 0, "end": 2299171, "filename": "/.git/refs/remotes/origin/HEAD"}, {"audio": 0, "start": 2299171, "crunched": 0, "end": 2299212, "filename": "/.git/refs/remotes/origin/master"}, {"audio": 0, "start": 2299212, "crunched": 0, "end": 2299371, "filename": "/.idea/encodings.xml"}, {"audio": 0, "start": 2299371, "crunched": 0, "end": 2299844, "filename": "/.idea/LuaSweeper.iml"}, {"audio": 0, "start": 2299844, "crunched": 0, "end": 2302521, "filename": "/.idea/misc.xml"}, {"audio": 0, "start": 2302521, "crunched": 0, "end": 2302793, "filename": "/.idea/modules.xml"}, {"audio": 0, "start": 2302793, "crunched": 0, "end": 2302960, "filename": "/.idea/vcs.xml"}, {"audio": 0, "start": 2302960, "crunched": 0, "end": 2352516, "filename": "/.idea/workspace.xml"}, {"audio": 0, "start": 2352516, "crunched": 0, "end": 2354214, "filename": "/assets/assets.lua"}, {"audio": 1, "start": 2354214, "crunched": 0, "end": 2665510, "filename": "/assets/audio/bomb_explode.wav"}, {"audio": 1, "start": 2665510, "crunched": 0, "end": 3425318, "filename": "/assets/audio/win.wav"}, {"audio": 0, "start": 3425318, "crunched": 0, "end": 3427266, "filename": "/assets/graphics/1.png"}, {"audio": 0, "start": 3427266, "crunched": 0, "end": 3429288, "filename": "/assets/graphics/2.png"}, {"audio": 0, "start": 3429288, "crunched": 0, "end": 3431404, "filename": "/assets/graphics/3.png"}, {"audio": 0, "start": 3431404, "crunched": 0, "end": 3433343, "filename": "/assets/graphics/4.png"}, {"audio": 0, "start": 3433343, "crunched": 0, "end": 3435335, "filename": "/assets/graphics/5.png"}, {"audio": 0, "start": 3435335, "crunched": 0, "end": 3437540, "filename": "/assets/graphics/6.png"}, {"audio": 0, "start": 3437540, "crunched": 0, "end": 3439462, "filename": "/assets/graphics/7.png"}, {"audio": 0, "start": 3439462, "crunched": 0, "end": 3441652, "filename": "/assets/graphics/8.png"}, {"audio": 0, "start": 3441652, "crunched": 0, "end": 3443159, "filename": "/assets/graphics/block_clicked.png"}, {"audio": 0, "start": 3443159, "crunched": 0, "end": 3445018, "filename": "/assets/graphics/block_unclicked.png"}, {"audio": 0, "start": 3445018, "crunched": 0, "end": 3447354, "filename": "/assets/graphics/bomb.png"}, {"audio": 0, "start": 3447354, "crunched": 0, "end": 3449689, "filename": "/assets/graphics/bomb_clicked.png"}, {"audio": 0, "start": 3449689, "crunched": 0, "end": 3453074, "filename": "/assets/graphics/bomb_wrong.png"}, {"audio": 0, "start": 3453074, "crunched": 0, "end": 3455262, "filename": "/assets/graphics/flag.png"}, {"audio": 0, "start": 3455262, "crunched": 0, "end": 3457804, "filename": "/assets/graphics/smiley.png"}, {"audio": 0, "start": 3457804, "crunched": 0, "end": 3460352, "filename": "/assets/graphics/smiley_green.png"}, {"audio": 0, "start": 3460352, "crunched": 0, "end": 3463080, "filename": "/assets/graphics/smiley_lose.png"}, {"audio": 0, "start": 3463080, "crunched": 0, "end": 3465606, "filename": "/assets/graphics/smiley_o.png"}, {"audio": 0, "start": 3465606, "crunched": 0, "end": 3468163, "filename": "/assets/graphics/smiley_red.png"}, {"audio": 0, "start": 3468163, "crunched": 0, "end": 3470756, "filename": "/assets/graphics/smiley_win.png"}, {"audio": 0, "start": 3470756, "crunched": 0, "end": 3474289, "filename": "/lib/gamestate.lua"}, {"audio": 0, "start": 3474289, "crunched": 0, "end": 3480731, "filename": "/lib/kalis.lua"}, {"audio": 0, "start": 3480731, "crunched": 0, "end": 3487654, "filename": "/spec/board_spec.lua"}, {"audio": 0, "start": 3487654, "crunched": 0, "end": 3494840, "filename": "/spec/cell_spec.lua"}, {"audio": 0, "start": 3494840, "crunched": 0, "end": 3496209, "filename": "/spec/highscores_spec.lua"}, {"audio": 0, "start": 3496209, "crunched": 0, "end": 3499519, "filename": "/src/board.lua"}, {"audio": 0, "start": 3499519, "crunched": 0, "end": 3503491, "filename": "/src/cell.lua"}, {"audio": 0, "start": 3503491, "crunched": 0, "end": 3504376, "filename": "/src/game.lua"}, {"audio": 0, "start": 3504376, "crunched": 0, "end": 3510123, "filename": "/src/highscores.lua"}, {"audio": 0, "start": 3510123, "crunched": 0, "end": 3510900, "filename": "/src/ui/button.lua"}, {"audio": 0, "start": 3510900, "crunched": 0, "end": 3511300, "filename": "/src/ui/label.lua"}, {"audio": 0, "start": 3511300, "crunched": 0, "end": 3512155, "filename": "/src/ui/UI.lua"}, {"audio": 0, "start": 3512155, "crunched": 0, "end": 3512803, "filename": "/states/displayHighScores.lua"}, {"audio": 0, "start": 3512803, "crunched": 0, "end": 3513714, "filename": "/states/endgame.lua"}, {"audio": 0, "start": 3513714, "crunched": 0, "end": 3515887, "filename": "/states/enterHighScores.lua"}, {"audio": 0, "start": 3515887, "crunched": 0, "end": 3517150, "filename": "/states/game.lua"}, {"audio": 0, "start": 3517150, "crunched": 0, "end": 3517933, "filename": "/states/menu.lua"}, {"audio": 0, "start": 3517933, "crunched": 0, "end": 3518589, "filename": "/states/pregame.lua"}], "remote_package_size": 3518589, "package_uuid": "91433c5b-827d-4c3f-82bb-c05ef442efd8"});

})();
