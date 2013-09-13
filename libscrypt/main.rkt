#lang racket/base
;
; libscrypt bindings
;

(require racket/contract)

(require "private/ffi.rkt")

(provide scrypt)


(define (coerce-bytes str-or-bstr)
  (if (string? str-or-bstr)
    (string->bytes/utf-8 str-or-bstr)
    str-or-bstr))


(define/contract (scrypt password salt
                         #:N (N 14) #:r (r 8) #:p (p 1) #:size (size 32))
                 (->* ((or/c string? bytes?)
                       (or/c string? bytes?))
                      (#:N exact-positive-integer?
                       #:r exact-positive-integer?
                       #:p exact-positive-integer?
                       #:size exact-positive-integer?)
                      bytes?)
  (let ((buffer   (make-bytes size))
        (password (coerce-bytes password))
        (salt     (coerce-bytes salt)))
    (unless (= 0 (libscrypt_scrypt password salt (expt 2 N) r p buffer))
      (error 'scrypt "unexpected scrypt error"))
    buffer))


; vim:set ts=2 sw=2 et:
