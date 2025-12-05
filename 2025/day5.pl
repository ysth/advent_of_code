use 5.036;
# day 5 https://adventofcode.com/2025/day/5
@ARGV = 'day5.txt' unless @ARGV;

my @ranges;
while (<>) {
    chomp;
    last unless length;
    /^(\d+)-(\d+)\z/a or die "bad: $_";
    push @ranges, [$1,$2];
}
my $fresh = 0;
while (<>) {
    chomp;
    /^(\d+)\z/a or die "bad: $_";
    for my $range (@ranges) {
        ++$fresh, last if $_ >= $range->[0] && $_ <= $range->[1];
    }
}
say $fresh;
