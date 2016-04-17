package ExtendEntryFieldFilter::Tags;
use strict;

sub _hdlr_extend_entry_field_filter {
    my ($ctx, $args, $cond) = @_;

    foreach my $arg (keys %$args) {
        if ($arg =~ m/^field:(.+)$/) {
            if (ref($args->{$arg}) eq 'ARRAY') {
                # LIKE検索
                if ($args->{$arg}->[0] eq 'LIKE') {
                    $args->{$arg} = ({ 'like' => $args->{$arg}->[1] });
                } else {
                    # 数値型の検索
                    if ($args->{$arg}->[0] eq '=') {
                        # "=","[value]"と記述する必要はないが、エラー回避のため。
                        $args->{$arg} = $args->{$arg}->[1];
                    } elsif ($args->{$arg}->[0] =~ m/^(>|<|=)+$/) {
                        $args->{$arg} = { $args->{$arg}->[0] => $args->{$arg}->[1] };
                    }
                }
            }
        }
    }

    # Call original tag handler with new args
    defined(my $result = $ctx->super_handler($args, $cond))
        or return $ctx->error($ctx->errstr);
    return $result;
}

1;
