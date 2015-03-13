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

# Install a Java app
class html5Poc {
    $app_zip = 'ateam-html5-poc-0.1-20150312.224228-1.zip'
    $app_url = "http://kfgodel.info:8081/nexus/content/repositories/snapshots/ar/com/tenpines/ateam-html5-poc/0.1-SNAPSHOT/${app_zip}"

    $working_dir = '/home/vagrant'
    file { "${working_dir}":
      ensure => "directory"
    }

    exec{ "download-app-zip":
        provider => shell,
        command => "cd ${working_dir}; wget ${app_url}" ,
        path => "/usr/bin/:/bin/",
        creates => "${working_dir}/${app_zip}",
        timeout =>  500,
        require => File["${working_dir}"]
    }

    package { "unzip":}


    $app_dir = "${working_dir}/ateam-html5-poc"
    exec{ "decompress-zip":
        provider => shell,
        command => "cd ${working_dir}; unzip ${app_zip}" ,
        path => "/usr/bin/:/bin/",
        creates => "${app_dir}",
        require => [ Package["unzip"], Exec["download-app-zip"] ]
    }

    exec{ "start-app":
        provider => shell,
        command => "cd ${app_dir}/bin; ./wrapper.sh start" ,
        path => "/usr/bin/:/bin/",
        creates => "${app_dir}/bin/EXECUTABLE_CONTAINER.pid",
        require => [ Package["unzip"], Exec["download-app-zip"] ]
    }

}

include html5Poc