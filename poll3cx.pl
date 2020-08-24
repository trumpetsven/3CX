#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use REST::Client;
use JSON;
# use IO::Socket::SSL qw( SSL_VERIFY_NONE ); # Uncomment this to skip SSL verification

my $client = REST::Client->new();
# $client->getUseragent()->ssl_opts(verify_hostname => 0); # Uncomment this to skip SSL verification
# $client->getUseragent()->ssl_opts(SSL_verify_mode => SSL_VERIFY_NONE); # Uncomment this to skip SSL verification

my $result = "";
$client->setHost('https://pbx.yourdomain.com');
$client->addHeader('Accept', 'application/json');
$client->addHeader('Content-Type', 'application/json');
$client->addHeader('charset', 'UTF-8');
$client->getUseragent()->cookie_jar({});

# print ": --- Poll 3CX ---\n";
my $req = '{"username":"123","password":"SECRET"}';
$client->POST('/api/login', $req);

if ($client->responseContent() eq 'AuthSuccess')
{
  # print ": login ok\n";
  $client->GET('/api/activeCalls');
  my $pbxdata = from_json($client->responseContent());
  
  # print Dumper $pbxdata;
	
  $req = '{}';
  $client->POST('/api/logout', $req);
  # print ": logout: ".$client->responseContent()."\n";

  # print Dumper $pbxdata;
  
  my $strext = "SIP-Trunk";
  my $calls_external = 0;
  my $calls_internal = 0;
  
  for my $item( @{$pbxdata->{'list'}} ) {
      # print $item->{'Caller'} . " ---> ". $item->{'Callee'} . "\n";
      
      if ( (index($item->{'Caller'}, $strext) != -1) || (index($item->{'Callee'}, $strext) != -1) ) {
        $calls_external++;
      }
      else {
        $calls_internal++;
      }
  }
  # print "Internal:".$calls_internal."  External:".$calls_external."\n";
  
  $result = '{ "prtg": { "result": [ { "channel": "calls_internal", "value": "'.$calls_internal.'" }, { "channel": "calls_external", "value": "'.$calls_external.'" }, { "channel": "sum", "value": "'. ($calls_external + $calls_internal).'" } ] } }';

  print $result . "\n";
 

}
else
{
	# print ": ERROR - Login failed >".$client->responseContent()."<\n";
  exit 1;
}

# print ": Finished\n";
exit 0;
