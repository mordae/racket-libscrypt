#lang racket/base
;
; FFI bindings for the scrypt library
;

(require (rename-in ffi/unsafe (-> -->))
         ffi/unsafe/define)

(provide libscrypt_scrypt)


(define-ffi-definer define-libscrypt
                    (ffi-lib "libscrypt" '("0" ""))
                    #:default-make-fail make-not-available)


(define-libscrypt libscrypt_scrypt
                  (_fun (password      : _bytes)
                        (password-size : _size = (bytes-length password))
                        (salt          : _bytes)
                        (salt-size     : _size = (bytes-length salt))
                        (N             : _uint64)
                        (r             : _uint32)
                        (p             : _uint32)
                        (buffer        : _bytes)
                        (buffer-size   : _size = (bytes-length buffer))
                        --> _int))


; vim:set ts=2 sw=2 et:
