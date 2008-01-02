use strict;
use warnings;
use utf8;
use Test::Base;
use Template;
use Encode;

# 鬱膣愛味噌

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
template: "[% USE MobileJPPictogram %][% x | pictogram_charname('***%s***') %]"
x: PICT:\x{E754}
--- expected: PICT:***ウマ***

===
--- input
template: |+
    [% USE MobileJPPictogram %][% x | pictogram_unicode('<img src="/img/pictogram/%04X.gif" />') %]
x: PICT:\x{E754}
--- expected
PICT:<img src="/img/pictogram/E754.gif" />

===
--- input
template: |+
    [% USE MobileJPPictogram %][% x | pictogram_unicode('<img src="/img/pictogram/%d.gif" />') %]
x: PICT:\x{E754}
--- expected
PICT:<img src="/img/pictogram/59220.gif" />

