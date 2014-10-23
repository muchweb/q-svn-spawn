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

## Return objects

Please refer to [svn-spawn documentation](https://github.com/ddliu/node-svn-spawn#result-object).

## Requirements

You need to have command line `svn` installed ([installation inscructions](https://subversion.apache.org/packages.html)).

## Installation

```bash
npm install q-svn-spawn
```

## Testing

Requires `nodeunit` installed globally.

```bash
npm test
```

## License ![GPL-3.0+](https://cloud.githubusercontent.com/assets/7157049/4762822/bb25d628-5b07-11e4-8b27-692c75e97759.png)

```
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```