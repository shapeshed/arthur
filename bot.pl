#!/usr/bin/perl

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




