use 5.036;
# day 8 https://adventofcode.com/2025/day/8
@ARGV = 'day8.txt' unless @ARGV;

my @boxes;
my %group;
while (my $row = <>) {
    chomp $row;
    my %box = ( group=> $. );
    @box{qw/x y z/} = split /,/, $row;
    push @boxes, \%box;
    push $group{$box{group}}->@*, \%box;
}

my @distance;
for my $i (0..($#boxes-1)) {
    my $box_i = $boxes[$i];
    for my $j (($i+1)..$#boxes) {
        my $box_j = $boxes[$j];
        push @distance, {
            distance_squared => ($box_i->{x}-$box_j->{x})**2 +($box_i->{y}-$box_j->{y})**2 +($box_i->{z}-$box_j->{z})**2,
            i => $box_i,
            j => $box_j,
        };
    }
}

@distance = sort { $a->{distance_squared} <=> $b->{distance_squared} || die "equidistant rows $a->{group} and $b->{group}" } @distance;

my $connect;
do {
    $connect = shift @distance;
    my ($box_i, $box_j) = @$connect{qw/i j/};
    if ($box_j->{group} != $box_i->{group}) {
        push $group{$box_i->{group}}->@*, $group{$box_j->{group}}->@*;
        $_->{group} = $box_i->{group} for (delete $group{$box_j->{group}})->@*;
    }
} while 1 < keys %group;

say $connect->{i}{x} * $connect->{j}{x};
