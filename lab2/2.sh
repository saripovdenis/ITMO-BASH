#!/bin/bash

ps aux | awk '{if ($11~/^\/sbin\/.*/) print $2}' > PIDin2-02.txt

