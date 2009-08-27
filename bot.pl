#!/usr/bin/perl
# File:        bot.pl
# Description: Wakes the bot and sets variables
#
# Copyright 2009 George Ornbo (Shape Shed)
#
# Licensed under the Open Source Initiative - BSD License (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://opensource.org/licenses/bsd-license.php
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# You may need to specify the path your the module:
# use lib '/home/george/arthur/';

use strict;
use Arthur; 

my $bot = Arthur->new();

#################################
# Username and password for the bot account
#################################
$bot->twitterUsername('your_username');
$bot->twitterPassword('your_password');

#################################
# The Search Term you want to RT
#################################
# Search term should be something like
# '#eggs OR #bacon'
$bot->searchString('#eggs OR #bacon');

#################################
# Do the magic..
#################################
$bot->post_to_twitter($bot->get_data());




