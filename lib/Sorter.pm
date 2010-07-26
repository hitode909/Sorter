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

sub set_values {
    my $self = shift;
    $self->values([@_]);
    undef $self->{_pivot};
    $self;
}

sub sort {
    my $self = shift;

    return $self->get_values if $self->_length <= 1;
    my $a = __PACKAGE__->new;
    my $b = __PACKAGE__->new;
    my $pivot = $self->_get_pivot;
    $a->set_values($self->_left($pivot));
    $b->set_values($self->_right($pivot));
    $a->sort;
    $b->sort;
    $self->set_values($a->get_values, $pivot, $b->get_values);
}

sub _get_pivot {
    my $self = shift;
    my @values = $self->get_values;
    my $index = int rand scalar @values;
    my $pivot = $values[$index];
    $self->set_values(@values[0..$index-1], @values[$index+1..(scalar @values-1)]);
    $pivot;
}

sub _length {
    my $self = shift;
    scalar @{$self->values};
}

sub _left {
    my ($self, $pivot) = @_;
    grep { $_ < $pivot } $self->get_values;
}

sub _right {
    my ($self, $pivot) = @_;
    grep { $_ >= $pivot } $self->get_values;
}

1;
