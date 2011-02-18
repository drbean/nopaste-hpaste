package App::Nopaste::Service::Hpaste;

# Created: 西元2011年02月15日 19時51分40秒
# Last Edit: 2011  2月 18, 12時07分30秒
# $Id$

=head1 NAME

Hpaste.pm - Paste to http://hpaste.org, the Haskell paste site

=cut

use strict;
use warnings;

=head1 SYNOPSIS

nopaste -s Hpaste -l haskell -n "Dr Bean" -d "Category theory" paste.txt

=cut

=head1 DESCRIPTION

hpaste requires a title, an author, and the paste. The default language is 'haskell.' No, it's 'perl', but it should be 'haskell'.

=cut

use base 'App::Nopaste::Service';

my $code;
my %Langs = (
    "" => "0",
    "Agda" => "1",
    "Bash" => "2",
    "C" => "3",
    "C++" => "4",
    "Common Lisp" => "5",
    "D" => "6",
    "Erlang" => "7",
    "Haskell" => "8",
    "Java" => "9",
    "JavaScript" => "10",
    "Literate Haskell" => "11",
    "Lua" => "12",
    "Objective-C" => "13",
    "OCaml" => "14",
    "Perl" => "15",
    "Prolog" => "16",
    "Python" => "17",
    "Ruby" => "18",
    "Scala" => "19",
    "SQL" => "20",
    "XML" => "21",
);
my %langs = map { lc($_) => $Langs{$_} } keys %Langs;
$code->{lang} = \%langs;

$code->{chan} = {
      "" => "0",
      "agda" => "1",
      "haskell" => "2",
      "javascript" => "3",
      "lisp" => "4",
      "python" => "5",
      "ruby" => "6",
      "scala" => "7",
      "xmonad" => "8",
};

sub uri { "http://hpaste.org/" }

sub fill_form {
    my $self = shift;
    my $mech = shift;
    my %args = @_;
    my $title;
    if ( $args{desc} ) {
	    $title = $args{desc};
    }
    else {
	    my ($line, $remains) = split "\n", $args{text};
	    $title = substr( $line, 0, 30 );
    }
    my $lang = $code->{lang}->{ (lc $args{lang}) || "haskell" };
    my $chan = $code->{chan}->{ $args{chan} || "" };

    $mech->field( 'fval[1]'    => $title );
    $mech->field( 'fval[2]'    => $args{nick} );
    $mech->field( 'fval[3]'    => $lang );
    $mech->field( 'fval[4]'    => $chan );
    $mech->field( 'fval[5]'    => $args{text} );
    $mech->click();
}

sub return {
    my $self = shift;
    my $mech = shift;

    my $link = $mech->uri();

    return (0, "No link to paste.") unless $link;
    return (1, $link);
}

1;



=head1 AUTHOR

Dr Bean C<< <drbean at cpan, then a dot, (.), and org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-/home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=/home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc /home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist//home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d//home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=/home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm>

=item * Search CPAN

L<http://search.cpan.org/dist//home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2011 Dr Bean, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;    # End of /home/drbean/hpaste/lib/App/Nopaste/ServiceHpaste.pm

# vim: set ts=8 sts=4 sw=4 noet:

