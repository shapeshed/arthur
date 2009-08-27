# Arthur - A Twitter Retweet Robot

* **Author**: [George Ornbo][]
* **Source Code**: [Github][]

## Compatibility

* Perl 5
* cURL support

## License

Arthur is free for personal and commercial use. 

If you use it commercially use a donation of $25 is suggested. You can send [donations here](http://pledgie.com/campaigns/5855). 

Arthur is licensed under a [Open Source Initiative - BSD License][] license.

## Installation

You need Perl and the following modules:

* WWW::Curl::Easy;
* JSON -support_by_pp;
* URI::Escape;

You can either put Arthur.pm in a standard Perl modules folder or link to it in the bot.pl file with something like:

	use lib '/home/george/arthur/';
	
bot.pl needs to be executable and in a folder that it can write to. bot.pl writes a text file that stores the last tweet id so it knows where to retweet from the next time. 

## Name

Arthur - A Twitter Retweet Robot

## Synopsis

Arthur is a Twitter Retweet Robot written in Perl. It allows you to retweet terms and hash tags.

## Description


You can run Arthur from the command line like this:

	perl bot.pl

Or you can put it in a cron job like this:

	*/1 * * * * /home/george/bots/ee_bot/bot.pl > /dev/null
 
Arthur does not retweet retweets or retweet himself. That would lead to some kind of horrible infinite loop of retweets. 

[George Ornbo]: http://shapeshed.com/
[Github]: http://github.com/shapeshed/arthur/
[ExpressionEngine]:http://www.expressionengine.com/index.php?affiliate=shapeshed
[Open Source Initiative - BSD License]: http://opensource.org/licenses/bsd-license.php