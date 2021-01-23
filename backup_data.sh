#!/usr/bin/env bash

rsync -anPv /media/storage /media/backup/storage 2>rsync.err
