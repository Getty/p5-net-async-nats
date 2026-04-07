package Net::Async::NATS::Subscription;
# ABSTRACT: Represents a NATS subscription
our $VERSION = '0.004';
use strict;
use warnings;

=head1 SYNOPSIS

    my $sub = await $nats->subscribe('foo.>', sub {
        my ($subject, $payload, $reply_to) = @_;
        # handle message
    });

    say $sub->sid;      # subscription ID
    say $sub->subject;  # subscribed subject

    await $nats->unsubscribe($sub);

=head1 DESCRIPTION

Lightweight object representing a single NATS subscription. Created by
L<Net::Async::NATS/subscribe> and passed to L<Net::Async::NATS/unsubscribe>.

=cut

sub new {
    my ($class, %args) = @_;
    return bless {
        sid       => $args{sid},
        subject   => $args{subject},
        queue     => $args{queue},
        callback  => $args{callback},
        max_msgs  => $args{max_msgs},
        _received => 0,
    }, $class;
}

=attr sid

The unique subscription identifier (integer).

=attr subject

The subject this subscription listens on.

=attr queue

Optional queue group name for load-balanced delivery.

=attr callback

The coderef invoked for each received message. Signature:
C<($subject, $payload, $reply_to)>.

=attr max_msgs

If set, the subscription auto-unsubscribes after receiving this many messages.

=cut

sub sid      { $_[0]->{sid} }
sub subject  { $_[0]->{subject} }
sub queue    { $_[0]->{queue} }
sub callback { $_[0]->{callback} }
sub max_msgs { $_[0]->{max_msgs} }

1;
