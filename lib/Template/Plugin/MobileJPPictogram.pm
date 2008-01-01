package Template::Plugin::MobileJPPictogram;

use strict;
use warnings;
our $VERSION = '0.01';

require Template::Plugin;
use base qw(Template::Plugin);

use Encode::JP::Mobile ':props';
use Encode::JP::Mobile::Charnames;

our $FILTER_NAME = 'escape_pictograms';

sub new {
    my ( $self, $context, @args ) = @_;
    my $format = $args[0] || '[%s]';
    my $name = $args[1] || $FILTER_NAME;
    $context->define_filter( $name, sub { commify($format, $_[0]) }, 0 );
    return $self;
}

sub commify {
    my $format = shift;
    local $_ = shift;

    s{(\p{InMobileJPPictograms})}{
        my $name = Encode::JP::Mobile::Charnames::unicode2name(unpack 'U*', $1);
        sprintf $format, $name;
    }ge;

    return $_;
}

1;
__END__

=for stopwords aaaatttt dotottto gmail

=head1 NAME

Template::Plugin::MobileJPPictogram -

=head1 SYNOPSIS

  use Template::Plugin::MobileJPPictogram;

=head1 DESCRIPTION

Template::Plugin::MobileJPPictogram is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom aaaatttt gmail dotottto commmmmE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
