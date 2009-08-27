#!/usr/bin/perl
# File:        Arthur.pm
# Description: Retweets specified search terms
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

package Arthur;

use strict;
use JSON -support_by_pp;
use URI::Escape;

#constructor
sub new {
	my ($class) = @_;
	my $self = {
	    _searchString => undef,
	    _twitterUsername  => undef,
	    _twitterPassword       => undef,
	};
	bless $self, $class;
	return $self;
}

#accessor method for Person first name
sub searchString {
    my ( $self, $searchString  ) = @_;
    $self->{_searchString } = $searchString if defined($searchString);
    return $self->{_searchString};
}

#accessor method for Person last name
sub twitterUsername {
    my ( $self, $twitterUsername ) = @_;
    $self->{_twitterUsername} = $twitterUsername if defined($twitterUsername);
    return $self->{_twitterUsername};
}

#accessor method for Person last name
sub twitterPassword {
    my ( $self, $twitterPassword ) = @_;
    $self->{_twitterPassword} = $twitterPassword if defined($twitterPassword);
    return $self->{_twitterPassword};
}

#################################
# Variables
#################################
my $json_data;
my $data;
my $results;
my $json;
my $last_status_id;
my $status_id;
my $tweet;
my $tweet_length;
my $over_length;
my $continued = "..";
my $search;
my $username;
my $password;

####################################
# Gets data from Twitter via cURL
####################################
sub get_data
	{
    	my ($self) = @_;

		$search = uri_escape_utf8($self->searchString);
		
		$data = `curl http://search.twitter.com/search.json?q=$search`;	
		
		$json = new JSON;
		
		$json_data = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($data);
		
		return $json_data;
	
	}

####################################
# Posts data to Twitter via cURL
####################################
sub post_to_twitter($json_data)
	{
    	my ($self) = @_;
		$username = $self->twitterUsername;
		$password = $self->twitterPassword;
				
		$status_id = $json_data->{results}[0]->{id};
			
		foreach $results(reverse(@{$json_data->{results}}))
		{
			$tweet = "RT \@$results->{from_user} $results->{text}";
			$tweet = trim_tweet(uri_escape_utf8($tweet));
		
			if (&get_status_id)
			{
				if ($results->{id} > &get_status_id)
				{
					`curl -u $username:$password -d "status=$tweet" http://twitter.com/statuses/update.json`
				}
			}
			else
			{
				`curl -u $username:$password -d "status=$tweet" http://twitter.com/statuses/update.json`			
			}
		}	
		
		&write_status_id;
	}

####################################
# Gets the latest status id from the 
# local file
####################################
sub get_status_id
	{	
		if (-e "last_status") 
		{
			open(STATUS,"last_status");	
			$last_status_id = <STATUS>;
			return($last_status_id);
		}
		else
		{
			return
		}
	}

####################################
# Posts data to Twitter via cURL
####################################
sub write_status_id
	{ 
		open(STATUS, ">last_status");
		print STATUS $status_id;
		close(STATUS);
		return 1;
	}

####################################
# If a Tweet is over 140 characters
# trim it and add ..
####################################
sub trim_tweet($tweet)
	{
		$tweet_length = length($tweet);
		if ($tweet_length > 140)
		{
			$over_length = $tweet_length - 138;
			substr($tweet, -$over_length) = "";
			return $tweet.$continued;
		}
		else
		{
			return($tweet);
		}	
	}
1;