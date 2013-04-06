

define ensure_key_value($file, $key, $value, $delimiter = " ") {
    # append line if "$key" not in "$file"
    exec { "append $key$delimiter$value $file":
        command => "echo '$key$delimiter$value' >> $file",
        unless => "grep -qe '^[[:space:]]*$key[[:space:]]*$delimiter' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin",
        before => Exec["update $key$delimiter$value $file"],
    }

    # update it if it already exists...
    exec { "update $key$delimiter$value $file":
        command => "sed --in-place='' --expression='s/^[[:space:]]*$key[[:space:]]*$delimiter.*$/$key$delimiter$value/g' $file",
        unless => "grep -xqe '$key$delimiter$value' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin"
    }
}
