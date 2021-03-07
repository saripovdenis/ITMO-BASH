#!/bin/bash

[ -d $HOME/test ] || #if directory exist - do nothing
{
  mkdir $HOME/test ;
  echo "catalog test was created successfully" > ~/report ;
  echo "catalog test was created successfully" ;
  cd $HOME/test ;
  touch $(echo `date +"%d.%m.%Y_%T"`)
};

ping -c1 "www.net_nikogo.ru" ||
echo $(date) " -- something went wrong. Whoops" >> ~/report

