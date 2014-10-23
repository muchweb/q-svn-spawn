'use strict'

Q = require 'q'
SVNSpawn = require 'svn-spawn'

module.exports = class

	constructor: (options) ->
		@swn_spawn = new SVNSpawn options;

	runCustom: (func, params) ->
		deferred = Q.defer()
		setImmediate =>

			unless params?
				@swn_spawn[func] (err, data) ->
					if err
						return deferred.reject err

					deferred.resolve data

			else
				@swn_spawn[func] params, (err, data) ->
					if err
						return deferred.reject err

					deferred.resolve data

		deferred.promise

	cmd: (params) ->
		@runCustom 'cmd', params

	checkout: (params) ->
		@runCustom 'checkout', params

	update: (params) ->
		@runCustom 'update', params

	commit: (params) ->
		@runCustom 'commit', params

	add: (params) ->
		@runCustom 'add', params

	del: (params) ->
		@runCustom 'del', params

	info: (params) ->
		@runCustom 'info', params

	getInfo: (params) ->
		@runCustom 'getInfo', params

	status: (params) ->
		@runCustom 'status', params

	getStatus: (params) ->
		@runCustom 'getStatus', params

	log: (params) ->
		@runCustom 'log', params

	getLog: (params) ->
		@runCustom 'getLog', params

	addLocal: (params) ->
		@runCustom 'addLocal', params

	addLocalUnversioned: (params) ->
		@runCustom 'addLocalUnversioned', params
