We've got a private registry: go.kjuulh.com/<package-name> this is basically
our way of mapping a path to github: github.com/kjuulh/<package-name> this is
allowed by the go package manager. However, this causes weird behavior in
renovate.

Go packages work in a strange way, it uses <package-name> to denote both a
project and a path, so if you have multiple go.mod files in a single repository
go package manager technically treats them as separate packages. We use this
feature to have multiple utility libraries in the same project, and as such use
the path feature. that is go.kjuulh.com/utility/logger/

However, renovate will update dependencies of the go.kjuulh.com/utility/logger
dependency in the depend libraries to the go.mod file in the root of the repo.
Such that

```
go.kjuulh.com/utility => 1.4.7
go.kjuulh.com/utility/logger => 0.4.3
```

will be updated as such in the dependent packages

```
go.kjuulh.com/utility => 1.4.7
go.kjuulh.com/utility/logger =>  1.4.7
```

This is likely because hard-coded in the renovate go modules indexer, it has
hard-coded handling for github, etc. An is only able to handle paths with more
than 3 `/` in the url, which as you can see above we don't have 🙈.

We'd be happy to contribute fixes for this feature, if that is of interest to
you =D.

We'll leave it up to you whatever the solution could be. However, we have some
suggestions.

- Allowing us to specify custom registries, and setting the search path for when
  the repository ends and when the path begins. That would look something like
  this

```json
{
  "goPrivateRegistries": [
    {
      "url": "go.kjuulh.com",
      "pattern": "/^.*/(?<package-name.*>/(?<package-path>*.))$/" // or just setting the number of slashes to parse. I.e. numSlashesBeforePath: 3
    }
  ]
}
```
