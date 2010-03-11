#!/bin/bash

rsync -a --delete /home/jogi/purepo/site/ jogi@progtest.kanti-wohlen.ch:public_html/puwebseite
rsync -a --delete /home/jogi/purepo/graph jogi@progtest.kanti-wohlen.ch:public_html
