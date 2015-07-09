#lang scribble/manual

@require[(for-label libscrypt)
         (for-label racket/base)
         (for-label openssl/sha1)]

@require[scribble/eval unstable/sandbox]

@(define scrypt-eval (make-log-based-eval "libscrypt-log" 'replay))
@interaction-eval[#:eval scrypt-eval (require libscrypt openssl/sha1)]

@title{libscrypt}
@author+email["Jan Dvorak" "mordae@anilinux.org"]

Colin Percival's SCrypt library bindings.
Provides the @racket[scrypt] function for secure password derivation.


@defmodule[libscrypt]

@defproc[(scrypt (password (or/c string? bytes?))
                 (salt     (or/c string? bytes?))
                 (#:N N exact-positive-integer? 14)
                 (#:r r exact-positive-integer? 8)
                 (#:p p exact-positive-integer? 1)
                 (#:size size exact-positive-integer? 32))
         bytes?]{
  Derive key of given size using user-supplied password and a salt.
  Salt should be random when you derive the key for permanent storage and
  needs to be stored along the password.  Salts must not be reused.

  It should be sufficient to call it with default options,
  specifying the output size only:

  @examples[#:eval scrypt-eval
    (time
      (bytes->hex-string
        (scrypt "secret" "salt" #:size 8)))
  ]

  If you need to tune the difficulty, for example to use more memory,
  you can do so.  The overall difficulty @racket[N] is given as exponent,
  @racket[r] is the memory cost and @racket[p] parallelisation.

  @examples[#:eval scrypt-eval
    (time
      (bytes->hex-string
        (scrypt "letmein" "sugar" #:N 14 #:r 28 #:p 1 #:size 16)))
  ]
}


@; vim:set ft=scribble sw=2 ts=2 et:
