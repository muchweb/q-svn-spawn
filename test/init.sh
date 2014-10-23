#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")"; pwd)
npm run posttest
mkdir -p $BASEDIR/tmp
svnadmin create $BASEDIR/tmp/repo
svn checkout file://$BASEDIR/tmp/repo $BASEDIR/tmp/copy
cp $BASEDIR/source/* $BASEDIR/tmp/copy -r
cd $BASEDIR/tmp/copy
svn st | grep "^\?" | awk "{print \$2}" | xargs svn add $1
svn commit -m 'init repo'
cd $BASEDIR