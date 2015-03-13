# Print puppet version
notify { "Puppet: ${puppetversion}": }

# Install Oracle Java 8
class oracleJava {

    $jdk_version = '8'

    file { '/tmp/java.preseed':
        content => "oracle-java${jdk_version}-installer shared/accepted-oracle-license-v1-1 select true",
        mode   => '0600',
        backup => false,
    }


    include apt

    apt::ppa { 'ppa:webupd8team/java': }

    package { "oracle-java${jdk_version}-installer":
        responsefile => '/tmp/java.preseed',
        require      => [
                        Apt::Ppa['ppa:webupd8team/java'],
                        File['/tmp/java.preseed']
                        ],
    }

    package { "oracle-java${jdk_version}-set-default":
        require => Package["oracle-java${jdk_version}-installer"]
    }
}

include oracleJava
