# PRIVATE CLASS: do not use directly
class git::repo::debian inherits git::repo {
  apt::source { $::git::repo::source_name:
    ensure      => $::git::repo::ensure,
    location    => $::git::repo::location,
    key         => $::git::repo::key,
    include_src => $::git::repo::include_src,
  }
}
