# q-svn-spawn

Wrapper for [ddliu](https://github.com/ddliu)'s [svn-spawn](https://github.com/ddliu/node-svn-spawn) that make use of [Q promises](https://github.com/kriskowal/q), that is easy way to access svn repository with node.js.

## Features

- Easy to use
- Fast way to add local changes
- Query SVN infomation as array or object
- Common SVN commands are all supported

## Usage

Create a SVN client instance

```js
var QSVNSpawn = require('q-svn-spawn'),
	client = new QSVNSpawn({
	    cwd: '/path to your SVN working directory',
	    username: 'username', // Optional if authentication not required or is already saved
	    password: 'password', // Optional if authentication not required or is already saved
	});
```

`svn update`

```js
client.update().done(function (data) {
    console.log('updated');
});
```

`svn info`

```js
client.getInfo().done(function (data) {
    console.log('Repository url is %s', data.url);
});
```

Make some changes and commit all

```js
client.addLocal().done(function (data) {
    console.log('All local changes has been added for commit');

    client.commit('commit message here').done(function (data) {
        console.log('local changes has been committed!');
    });
});
```

Adding single file

```js
client.add('relative/path/to/file').done(function (data) {
    client.commit(['commit message here', 'relative/path/to/file']).done(function (data) {
        console.log('Committed one file!');
    });
});
```

Run any SVN command

```js
client.cmd(['subcommand', '--option1=xx', '--option2=xx', 'arg1', 'arg2']).done(function (data) {
    console.log('Subcommand done');
});
```

## Result Object

`getXXX` methods will return parsed data as object.

`getInfo` result example:

```json
{
  "$": {
    "path": ".",
    "revision": "1",
    "kind": "dir"
  },
  "url": "file:///home/dong/projects/node-packages/node-svn-spawn/test/tmp/repo",
  "repository": {
    "root": "file:///home/dong/projects/node-packages/node-svn-spawn/test/tmp/repo",
    "uuid": "302eb8ee-a81a-4432-8477-1ad8fe3a9a1e"
  },
  "wc-info": {
    "wcroot-abspath": "/home/dong/projects/node-packages/node-svn-spawn/test/tmp/copy",
    "schedule": "normal",
    "depth": "infinity"
  },
  "commit": {
    "$": {
      "revision": "1"
    },
    "author": "dong",
    "date": "2013-11-08T02:07:25.884985Z"
  }
}
```

`getLog` result example:

```json
[
    {
      "$": {
        "revision": "1"
      },
      "author": "dong",
      "date": "2013-11-08T02:10:37.656902Z",
      "msg": "init repo"
    },
    ...
]
```

`getStatus` result example:

```json
[
  {
    "$": {
      "path": "a.txt"
    },
    "wc-status": {
      "$": {
        "props": "none",
        "item": "modified",
        "revision": "1"
      },
      "commit": {
        "$": {
          "revision": "1"
        },
        "author": "dong",
        "date": "2013-11-08T02:17:20.390152Z"
      }
    }
  }
]
```

## Requirements

You need to have the `svn` command installed.


## Installation

```bash
npm install q-svn-spawn
```

## Testing

```bash
npm test
```