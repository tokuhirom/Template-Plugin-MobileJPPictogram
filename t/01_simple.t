use strict;
use warnings;
use utf8;
use Test::Base;
use Template;
use Encode;

filters {
    input => [qw/yaml escape/],
};

sub decode_uni {
    local $_ = shift;
    s/\\x\{(....)\}/pack "U*", hex $1/ge;
    $_;
}

sub escape {
    my $in = shift;
    my $tt = Template->new;
    $tt->process(\$in->{template}, {x => decode_uni($in->{x})}, \my $out) or die $tt->error;
    $out;
}

run_is input => 'expected';

__END__

===
--- input
template: "[% USE MobileJPPictogram %][% x | escape_pictograms %]"
x: PICT:\x{E001}
--- expected: PICT:[男の子]

