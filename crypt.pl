#!/usr/bin/perl

$plain = $ARGV[0];
@salt = 
('.','/','0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
,'G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t'
,'u','v','w','x','y','z');

$one = int(rand(100)) % 64;
$two = int(rand(100)) % 64; 
$passwd = crypt($plain, $salt[$one].$salt[$two]);
print $passwd;
