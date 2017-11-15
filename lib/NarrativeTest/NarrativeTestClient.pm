package NarrativeTest::NarrativeTestClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

NarrativeTest::NarrativeTestClient

=head1 DESCRIPTION


A KBase module: NarrativeTest


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => NarrativeTest::NarrativeTestClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my %arg_hash2 = @args;
	if (exists $arg_hash2{"token"}) {
	    $self->{token} = $arg_hash2{"token"};
	} elsif (exists $arg_hash2{"user_id"}) {
	    my $token = Bio::KBase::AuthToken->new(@args);
	    if (!$token->error_message) {
	        $self->{token} = $token->token;
	    }
	}
	
	if (exists $self->{token})
	{
	    $self->{client}->{token} = $self->{token};
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 test_async_job

  $return = $obj->test_async_job($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a NarrativeTest.TestAsyncJobParams
$return is a NarrativeTest.TestAsyncJobResults
TestAsyncJobParams is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_name
	input_genome_name has a value which is a NarrativeTest.genome_name
	output_genome_name has a value which is a NarrativeTest.genome_name
workspace_name is a string
genome_name is a string
TestAsyncJobResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string
	new_genome_ref has a value which is a NarrativeTest.ws_contigset_id
ws_contigset_id is a string

</pre>

=end html

=begin text

$params is a NarrativeTest.TestAsyncJobParams
$return is a NarrativeTest.TestAsyncJobResults
TestAsyncJobParams is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_name
	input_genome_name has a value which is a NarrativeTest.genome_name
	output_genome_name has a value which is a NarrativeTest.genome_name
workspace_name is a string
genome_name is a string
TestAsyncJobResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string
	new_genome_ref has a value which is a NarrativeTest.ws_contigset_id
ws_contigset_id is a string


=end text

=item Description

Asynchronously copies a genome into another genome. Ta-daaa!

=back

=cut

 sub test_async_job
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function test_async_job (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to test_async_job:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'test_async_job');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.test_async_job",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'test_async_job',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method test_async_job",
					    status_line => $self->{client}->status_line,
					    method_name => 'test_async_job',
				       );
    }
}
 


=head2 test_editor

  $return = $obj->test_editor($editor, $workspace)

=over 4

=item Parameter and return types

=begin html

<pre>
$editor is a string
$workspace is a NarrativeTest.workspace_name
$return is a NarrativeTest.TestEditorResults
workspace_name is a string
TestEditorResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string
	output has a value which is a string

</pre>

=end html

=begin text

$editor is a string
$workspace is a NarrativeTest.workspace_name
$return is a NarrativeTest.TestEditorResults
workspace_name is a string
TestEditorResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string
	output has a value which is a string


=end text

=item Description



=back

=cut

 sub test_editor
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function test_editor (received $n, expecting 2)");
    }
    {
	my($editor, $workspace) = @args;

	my @_bad_arguments;
        (!ref($editor)) or push(@_bad_arguments, "Invalid type for argument 1 \"editor\" (value was \"$editor\")");
        (!ref($workspace)) or push(@_bad_arguments, "Invalid type for argument 2 \"workspace\" (value was \"$workspace\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to test_editor:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'test_editor');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.test_editor",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'test_editor',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method test_editor",
					    status_line => $self->{client}->status_line,
					    method_name => 'test_editor',
				       );
    }
}
 


=head2 save_reads_set_v1

  $outputs = $obj->save_reads_set_v1($inputs)

=over 4

=item Parameter and return types

=begin html

<pre>
$inputs is an UnspecifiedObject, which can hold any non-null object
$outputs is an UnspecifiedObject, which can hold any non-null object

</pre>

=end html

=begin text

$inputs is an UnspecifiedObject, which can hold any non-null object
$outputs is an UnspecifiedObject, which can hold any non-null object


=end text

=item Description



=back

=cut

 sub save_reads_set_v1
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function save_reads_set_v1 (received $n, expecting 1)");
    }
    {
	my($inputs) = @args;

	my @_bad_arguments;
        (defined $inputs) or push(@_bad_arguments, "Invalid type for argument 1 \"inputs\" (value was \"$inputs\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to save_reads_set_v1:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'save_reads_set_v1');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.save_reads_set_v1",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'save_reads_set_v1',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method save_reads_set_v1",
					    status_line => $self->{client}->status_line,
					    method_name => 'save_reads_set_v1',
				       );
    }
}
 


=head2 test_param_groups

  $return = $obj->test_param_groups($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a NarrativeTest.TestParamGroupsParams
$return is a NarrativeTest.ReportOutput
TestParamGroupsParams is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_name
	param_group has a value which is a reference to a list where each element is a NarrativeTest.SimpleParamGroup
workspace_name is a string
SimpleParamGroup is a reference to a hash where the following keys are defined:
	genome_ref has a value which is a string
	free_text has a value which is a reference to a list where each element is a string
	check has a value which is an int
ReportOutput is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string

</pre>

=end html

=begin text

$params is a NarrativeTest.TestParamGroupsParams
$return is a NarrativeTest.ReportOutput
TestParamGroupsParams is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_name
	param_group has a value which is a reference to a list where each element is a NarrativeTest.SimpleParamGroup
workspace_name is a string
SimpleParamGroup is a reference to a hash where the following keys are defined:
	genome_ref has a value which is a string
	free_text has a value which is a reference to a list where each element is a string
	check has a value which is an int
ReportOutput is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string


=end text

=item Description



=back

=cut

 sub test_param_groups
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function test_param_groups (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to test_param_groups:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'test_param_groups');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.test_param_groups",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'test_param_groups',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method test_param_groups",
					    status_line => $self->{client}->status_line,
					    method_name => 'test_param_groups',
				       );
    }
}
 


=head2 test_input_mapping

  $outputs = $obj->test_input_mapping($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a NarrativeTest.SimpleTestObject
$outputs is an UnspecifiedObject, which can hold any non-null object
SimpleTestObject is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_id
	file_path has a value which is a string
workspace_id is a string

</pre>

=end html

=begin text

$params is a NarrativeTest.SimpleTestObject
$outputs is an UnspecifiedObject, which can hold any non-null object
SimpleTestObject is a reference to a hash where the following keys are defined:
	workspace has a value which is a NarrativeTest.workspace_id
	file_path has a value which is a string
workspace_id is a string


=end text

=item Description



=back

=cut

 sub test_input_mapping
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function test_input_mapping (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to test_input_mapping:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'test_input_mapping');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.test_input_mapping",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'test_input_mapping',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method test_input_mapping",
					    status_line => $self->{client}->status_line,
					    method_name => 'test_input_mapping',
				       );
    }
}
 


=head2 generic_test

  $outputs = $obj->generic_test($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is an UnspecifiedObject, which can hold any non-null object
$outputs is an UnspecifiedObject, which can hold any non-null object

</pre>

=end html

=begin text

$params is an UnspecifiedObject, which can hold any non-null object
$outputs is an UnspecifiedObject, which can hold any non-null object


=end text

=item Description



=back

=cut

 sub generic_test
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function generic_test (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (defined $params) or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to generic_test:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'generic_test');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.generic_test",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'generic_test',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method generic_test",
					    status_line => $self->{client}->status_line,
					    method_name => 'generic_test',
				       );
    }
}
 


=head2 import_reads_from_staging

  $returnVal = $obj->import_reads_from_staging($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a NarrativeTest.UploadReadsParams
$returnVal is a NarrativeTest.UploadMethodResult
UploadReadsParams is a reference to a hash where the following keys are defined:
	import_type has a value which is a string
	fastq_fwd_staging_file_name has a value which is a string
	fastq_rev_staging_file_name has a value which is a string
	sra_staging_file_name has a value which is a string
	sequencing_tech has a value which is a NarrativeTest.sequencing_tech
	workspace_name has a value which is a NarrativeTest.workspace_name
	name has a value which is a string
	single_genome has a value which is a NarrativeTest.single_genome
	interleaved has a value which is a NarrativeTest.interleaved
	insert_size_mean has a value which is a NarrativeTest.insert_size_mean
	insert_size_std_dev has a value which is a NarrativeTest.insert_size_std_dev
	read_orientation_outward has a value which is a NarrativeTest.read_orientation_outward
sequencing_tech is a string
workspace_name is a string
single_genome is a string
interleaved is a string
insert_size_mean is a string
insert_size_std_dev is a string
read_orientation_outward is a string
UploadMethodResult is a reference to a hash where the following keys are defined:
	obj_ref has a value which is a NarrativeTest.obj_ref
	report_name has a value which is a NarrativeTest.report_name
	report_ref has a value which is a NarrativeTest.report_ref
obj_ref is a string
report_name is a string
report_ref is a string

</pre>

=end html

=begin text

$params is a NarrativeTest.UploadReadsParams
$returnVal is a NarrativeTest.UploadMethodResult
UploadReadsParams is a reference to a hash where the following keys are defined:
	import_type has a value which is a string
	fastq_fwd_staging_file_name has a value which is a string
	fastq_rev_staging_file_name has a value which is a string
	sra_staging_file_name has a value which is a string
	sequencing_tech has a value which is a NarrativeTest.sequencing_tech
	workspace_name has a value which is a NarrativeTest.workspace_name
	name has a value which is a string
	single_genome has a value which is a NarrativeTest.single_genome
	interleaved has a value which is a NarrativeTest.interleaved
	insert_size_mean has a value which is a NarrativeTest.insert_size_mean
	insert_size_std_dev has a value which is a NarrativeTest.insert_size_std_dev
	read_orientation_outward has a value which is a NarrativeTest.read_orientation_outward
sequencing_tech is a string
workspace_name is a string
single_genome is a string
interleaved is a string
insert_size_mean is a string
insert_size_std_dev is a string
read_orientation_outward is a string
UploadMethodResult is a reference to a hash where the following keys are defined:
	obj_ref has a value which is a NarrativeTest.obj_ref
	report_name has a value which is a NarrativeTest.report_name
	report_ref has a value which is a NarrativeTest.report_ref
obj_ref is a string
report_name is a string
report_ref is a string


=end text

=item Description



=back

=cut

 sub import_reads_from_staging
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function import_reads_from_staging (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to import_reads_from_staging:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'import_reads_from_staging');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "NarrativeTest.import_reads_from_staging",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'import_reads_from_staging',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method import_reads_from_staging",
					    status_line => $self->{client}->status_line,
					    method_name => 'import_reads_from_staging',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "NarrativeTest.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "NarrativeTest.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'import_reads_from_staging',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method import_reads_from_staging",
            status_line => $self->{client}->status_line,
            method_name => 'import_reads_from_staging',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for NarrativeTest::NarrativeTestClient\n";
    }
    if ($sMajor == 0) {
        warn "NarrativeTest::NarrativeTestClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 contigset_id

=over 4



=item Description

A string representing a ContigSet id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 workspace_name

=over 4



=item Description

A string representing a workspace name.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 workspace_id

=over 4



=item Description

A string representing a workspace id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 ws_contigset_id

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 genome_name

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 TestAsyncJobParams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_name
input_genome_name has a value which is a NarrativeTest.genome_name
output_genome_name has a value which is a NarrativeTest.genome_name

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_name
input_genome_name has a value which is a NarrativeTest.genome_name
output_genome_name has a value which is a NarrativeTest.genome_name


=end text

=back



=head2 TestAsyncJobResults

=over 4



=item Description

The workspace ID for a ContigSet data object.
@id ws KBaseGenomes.ContigSet


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string
new_genome_ref has a value which is a NarrativeTest.ws_contigset_id

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string
new_genome_ref has a value which is a NarrativeTest.ws_contigset_id


=end text

=back



=head2 TestEditorResults

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string
output has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string
output has a value which is a string


=end text

=back



=head2 ReportOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string


=end text

=back



=head2 SimpleParamGroup

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
genome_ref has a value which is a string
free_text has a value which is a reference to a list where each element is a string
check has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
genome_ref has a value which is a string
free_text has a value which is a reference to a list where each element is a string
check has a value which is an int


=end text

=back



=head2 TestParamGroupsParams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_name
param_group has a value which is a reference to a list where each element is a NarrativeTest.SimpleParamGroup

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_name
param_group has a value which is a reference to a list where each element is a NarrativeTest.SimpleParamGroup


=end text

=back



=head2 SimpleTestObject

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_id
file_path has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace has a value which is a NarrativeTest.workspace_id
file_path has a value which is a string


=end text

=back



=head2 sequencing_tech

=over 4



=item Description

sequencing_tech: sequencing technology
name: output reads file name
workspace_name: workspace name/ID of the object
import_type: either FASTQ or SRA

For files in user's staging area:
fastq_fwd_or_sra_staging_file_name: single-end fastq file name Or forward/left paired-end fastq file name from user's staging area Or SRA staging file
fastq_rev_staging_file_name: reverse/right paired-end fastq file name user's staging area
e.g.
  for file: /data/bulk/user_name/file_name
  staging_file_subdir_path is file_name
  for file: /data/bulk/user_name/subdir_1/subdir_2/file_name
  staging_file_subdir_path is subdir_1/subdir_2/file_name

Optional Params:
single_genome: whether the reads are from a single genome or a metagenome.
interleaved: whether reads is interleaved
insert_size_mean: mean (average) insert length
insert_size_std_dev: standard deviation of insert lengths
read_orientation_outward: whether reads in a pair point outward


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 interleaved

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 insert_size_mean

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 insert_size_std_dev

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 read_orientation_outward

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 obj_ref

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 report_name

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 report_ref

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 single_genome

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 UploadReadsParams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
import_type has a value which is a string
fastq_fwd_staging_file_name has a value which is a string
fastq_rev_staging_file_name has a value which is a string
sra_staging_file_name has a value which is a string
sequencing_tech has a value which is a NarrativeTest.sequencing_tech
workspace_name has a value which is a NarrativeTest.workspace_name
name has a value which is a string
single_genome has a value which is a NarrativeTest.single_genome
interleaved has a value which is a NarrativeTest.interleaved
insert_size_mean has a value which is a NarrativeTest.insert_size_mean
insert_size_std_dev has a value which is a NarrativeTest.insert_size_std_dev
read_orientation_outward has a value which is a NarrativeTest.read_orientation_outward

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
import_type has a value which is a string
fastq_fwd_staging_file_name has a value which is a string
fastq_rev_staging_file_name has a value which is a string
sra_staging_file_name has a value which is a string
sequencing_tech has a value which is a NarrativeTest.sequencing_tech
workspace_name has a value which is a NarrativeTest.workspace_name
name has a value which is a string
single_genome has a value which is a NarrativeTest.single_genome
interleaved has a value which is a NarrativeTest.interleaved
insert_size_mean has a value which is a NarrativeTest.insert_size_mean
insert_size_std_dev has a value which is a NarrativeTest.insert_size_std_dev
read_orientation_outward has a value which is a NarrativeTest.read_orientation_outward


=end text

=back



=head2 UploadMethodResult

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
obj_ref has a value which is a NarrativeTest.obj_ref
report_name has a value which is a NarrativeTest.report_name
report_ref has a value which is a NarrativeTest.report_ref

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
obj_ref has a value which is a NarrativeTest.obj_ref
report_name has a value which is a NarrativeTest.report_name
report_ref has a value which is a NarrativeTest.report_ref


=end text

=back



=cut

package NarrativeTest::NarrativeTestClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;