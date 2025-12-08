use 5.036;
use List::Util 'product';
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

my $connections = @boxes == 20 ? 10 : 1000;
for (1..$connections)  {
    my $connect = shift @distance or last;
    my ($box_i, $box_j) = @$connect{qw/i j/};
    if ($box_j->{group} != $box_i->{group}) {
        push $group{$box_i->{group}}->@*, $group{$box_j->{group}}->@*;
        $_->{group} = $box_i->{group} for (delete $group{$box_j->{group}})->@*;
    }
}

say product((sort { $b <=> $a  } map scalar @$_, values %group)[0..2])
