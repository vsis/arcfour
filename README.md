# Arcfour and CipherSaber

This is my implementation of RC4 algorithm and [CipherSaber](http://ciphersaber.gurus.org/).

You may run some functional tests with:

```
make check
```

Also you may build the project with:

```
make
```

## Arcfour

To cipher a file with RC4, you need a (hopefully secret) key stored in a file. `arcfour` program will cipher or decipher the `stdin` and write the result to `stdout`.

For example:

```
echo -n "Secret" > my.key       # my secret key
echo -n "Attack at dawn" | ./arcfour my.key > message.rc4       # The encrypted message
```

To decipher, you need the same key:

```
./arcfour my.key < message.rc4
```

## CipherSaber

To cipher with CipherSaber, you also need a secret key, but the first parameter is `cipher` or `decipher`.

```
echo -n "Attack at dawn" | ./saber1 cipher my.key > message.cs
```

Then, if you want to decipher the message:

```
./saber1 decipher my.key < message.cs
```

## Creating a key

There is a lot of way to create a secret key. You may use a passphrase or a random stream of bytes.

This is a way to create a secret key with 128 bytes long:

```
head -c 128 < /dev/urandom > my.key
chmod 400 my.key
```
