#!/usr/bin/perl
# ex:ts=4

# iptables -t mangle -A OUTPUT --proto udp --destination-port 5060 --jump QUEUE

use strict;
$^W = 1;
use NetPacket::IP;
use NetPacket::UDP;

use IPTables::IPv4::IPQueue qw(:constants);

my ($queue, $msg);

$queue = new IPTables::IPv4::IPQueue(copy_mode => IPQ_COPY_PACKET, copy_range => 2048)
	or die IPTables::IPv4::IPQueue->errstr;

while (1) {

	$msg = $queue->get_message()
		or die IPTables::IPv4::IPQueue->errstr;
	
	print "Modify packet " . $msg->packet_id() . "\n";

	my $ip = NetPacket::IP->decode($msg->payload);
	my $udp = NetPacket::UDP->decode($ip->{data});

	# Do here the on-the-fly changes
	print "Deleting content-disposition header\n";
	$udp->{data} =~ s/Content-Disposition: session;handling=required$//;

	$ip->{data} = $udp->encode($ip);
	my $raw = $ip->encode;

	$queue->set_verdict($msg->packet_id, NF_ACCEPT, length($raw), $raw) > 0
		or die IPTables::IPv4::IPQueue->errstr;
}
