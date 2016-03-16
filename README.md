# InstaHuskee

An opinionated wrapper around https://hackage.haskell.org/package/ig with a Yesod UI.

_Note : This is WIP❗_

## Dependencies

Haskell (get ghc and stack).

## Setup

### Credentials & RedirectURI

Will be addressed by [#1](https://github.com/dzotokan/instahuskee/issues/1).

Meanwhile - see [an example](https://github.com/dzotokan/instahuskee/blob/master/src/InstaHuskee.hs#L32) of how to set these for now.

## Web Module

### Running

**Run [Stack](http://docs.haskellstack.org/en/stable/README/) repl**
```bash
stack repl
```

**Import the web module and run it**
```haskell
> import Web.Application
> run
```

Will start a server listening on port 4242.

**Check it**

[http://localhost:4242](http://localhost:4242)

### Routes

[/auth](http://localhost:4242/auth) - authentication route (your credentials have to be set correctly for this to work)



