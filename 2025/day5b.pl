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
my $fresh;
my $last_range;
for my $range (sort {$a->[0] <=> $b->[0]} @ranges) {
    if ($last_range && $last_range->[1] >= $range->[0]) {
        $fresh += $range->[1] - $last_range->[1], $last_range->[1] = $range->[1] if $range->[1] > $last_range->[1];
    }
    else {
        $last_range = $range;
        $fresh += $range->[1] - $range->[0] + 1;
    }
}

say $fresh;
