use 5.036;
use Algorithm::BitVector;

@ARGV = 'day4.txt' unless @ARGV;

# get first row
my $grid = <>;
# width including newline (which in our stored form will be replaced with an empty column to the left)
my $width = length $grid;

# get rest, add an empty row at top and bottom and empty column and convert to string of 0 and 1
$grid = join('.', '.' x $width, $grid, <>, '.' x $width) =~ y/@.\n/10/rd;

# section of grid we need to check: one row above and one position to the left of the target, plus it and everything right of it
my $surrounding_bitstring = '111' . '0' x ($width - 3) . '101' . '0' x ($width - 3) . '111';
my $surrounding_to_one_side = $width + 1;
my $surrounding = Algorithm::BitVector->new('bitstring' => $surrounding_bitstring);

$grid = Algorithm::BitVector->new('bitstring' => $grid);

my $total_removed = 0;
my $removed_rolls;
do {
    $removed_rolls = 0;

    my $bit = $surrounding_to_one_side - 1;
    while (($bit = $grid->next_set_bit(++$bit)) >= 0) {
        if (($grid->get_slice([($bit - $surrounding_to_one_side)..($bit+$surrounding_to_one_side+1)]) & $surrounding)->count_bits() < 4) {
            $grid->set_bit($bit, 0);
            ++$removed_rolls;
        }
    }

    $total_removed += $removed_rolls;
    say localtime()." removed $removed_rolls for $total_removed total";
} while $removed_rolls;
say $total_removed;
