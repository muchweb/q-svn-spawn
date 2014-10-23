# q-svn-spawn [![Build Status](https://travis-ci.org/muchweb/q-svn-spawn.svg?branch=master)](https://travis-ci.org/muchweb/q-svn-spawn) [![Dependency Status](https://gemnasium.com/muchweb/q-svn-spawn.svg)](https://gemnasium.com/muchweb/q-svn-spawn) [![NPM version](https://badge.fury.io/js/q-svn-spawn.svg)](http://badge.fury.io/js/q-svn-spawn)

Wrapper for [@ddliu](https://github.com/ddliu)'s [svn-spawn](https://github.com/ddliu/node-svn-spawn) that makes use of [Q promises](https://github.com/kriskowal/q); an easy way to access SVN repository with node.js.

## Features
- Easy to use
- Fast way to add local changes
- Query SVN infomation as array or object
- Common SVN commands are all supported

## Usage
Create an SVN client instance

```javascript
var QSVNSpawn = require('q-svn-spawn'),
	client = new QSVNSpawn({

        // Path to your SVN working directory
		cwd: '/bar',

		// Optional, authentication not required if already saved
		username: 'username',
		password: 'password',

	});
```

### `svn update`

```javascript
client.update().done(function (data) {
	console.log('Updated');
});
```

### `svn info`

```javascript
client.getInfo().done(function (data) {
	console.log('Repository url is %s', data.url);
});
```

### `svn commit`

Make some changes and commit all changed files

```javascript
console.log('Adding local changes to commit');
client.addLocal()
	.then(function () {
		console.log('Committing to repository');
		return client.commit('commit message here');
	})
	.done(function () {
		console.log('Local changes has been committed!');
	});
```

or only single changed file

```javascript

client.add('relative/path/to/file')
	.then(function () {
		return client.commit(['commit message here', 'relative/path/to/file']);
	})
	.done(function (data) {
		console.log('Committed one file!', data);
	});
```

### Any other command

```javascript
client.cmd(['subcommand', '--option1=xx', '--option2=xx', 'arg1', 'arg2']).done(function (data) {
	console.log('Subcommand done');
});
```

## Result Object

For return value documentation please refer to [svn-spawn documentation](https://github.com/ddliu/node-svn-spawn#result-object).

## Requirements

You need to have the `svn` command installed.

## Installation

```bash
npm install q-svn-spawn
```

## Testing

Requires `nodeunit` installed globally.

```bash
npm test
```
