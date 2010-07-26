package Sorter;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(values));

sub new {
    my $self = shift;
    $self->SUPER::new({values => [], @_});
}

sub get_values {
    my $self = shift;
    @{$self->values};
}

sub get_value {
    my ($self, $index) = @_;
    $self->values->[$index];
}

sub set_values {
    my $self = shift;
    $self->values([@_]);
    $self;
}

sub push_value {
    my ($self, $value) = @_;
    push @{$self->values}, $value;
    $self;
}

sub sort {
    my $self = shift;

    return $self unless $self->length > 1;

    my $pivot_index = int rand $self->length;
    my $pivot = $self->get_value($pivot_index);

    my $left  = __PACKAGE__->new;
    my $right = __PACKAGE__->new;

    foreach (0..$self->length-1) {
        next if $_ == $pivot_index;
        my $value = $self->get_value($_);
        ($value < $pivot ? $left : $right)->push_value($value);
    }

    $left->sort;
    $right->sort;
    $self->set_values($left->get_values, $pivot, $right->get_values);
    $self;
}

sub length {
    my $self = shift;
    scalar @{$self->values};
}

1;
