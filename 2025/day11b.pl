use 5.036;

# day 11 https://adventofcode.com/2025/day/11

use ARGV::OrDATA;

my %devices;
while (my $device = <>) {
    my ($name, @attached) = $device =~ /(?|^(\S+?):(?!$)|\G (\S++))/g
        or die "bad: $device";

    die "duplicate device $name" if $devices{$name};
    $devices{$name} = { 'attached' => \@attached  };
}
$devices{'out'}{'end'} = 1;

say path_count('svr', \%devices, {'fft' => 0, 'dac' => 1})->{3} || 0;

# returns a hashref of path counts from $start to the end where keys are a bitmask of which required devices were included in the path
sub path_count($start, $devices, $required) {
    if ($devices->{$start}{'counts'}) {
        return $devices->{$start}{'counts'};
    }
    if ($devices->{$start}{'end'}) {
        return $devices->{$start}{'counts'} = { 0 => 1 };
    }
    my %counts;
    my $add_required = (exists $required->{$start} ? 2**$required->{$start} : 0);
    for my $attached ($devices->{$start}{'attached'}->@*) {
        my $sub_counts = path_count($attached, $devices, $required);
        $counts{$add_required | $_} += $sub_counts->{$_} for keys %$sub_counts;
    }
    return $devices->{$start}{'counts'} = \%counts;
}

__DATA__
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
