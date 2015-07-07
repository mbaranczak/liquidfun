/*
 * Copyright (c) 2014 Google, Inc.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 1. The origin of this software must not be misrepresented; you must not
 * claim that you wrote the original software. If you use this software
 * in a product, an acknowledgment in the product documentation would be
 * appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 * misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

%module b2PolygonShape

/// Allow a constructor to be generated despite inheriting from an abstract
/// class with no default constructors
%feature("notabstract") b2PolygonShape;

%typemap(jni) (b2Vec2 *points, int32 count) "jobject"
%typemap(jtype) (b2Vec2 *points, int32 count) "java.nio.ByteBuffer"
%typemap(jstype) (b2Vec2 *points, int32 count) "java.nio.ByteBuffer"
%typemap(javain) (b2Vec2 *points, int32 count) "$javainput"
%typemap(javaout) (b2Vec2 *points, int32 count) {
    return $jnicall;
}
// This extracts the Java ByteBuffer address from C++
%typemap(in) (b2Vec2 *points, int32 count) {
    $1 = (b2Vec2*) jenv->GetDirectBufferAddress($input);
    $2 = jenv->GetDirectBufferCapacity($input) / 8;
    if (($1 == NULL) && ($2 != 0)) {
        SWIG_JavaThrowException(
                jenv,
                SWIG_JavaRuntimeException,
                "Unable to get address of java.nio.ByteBuffer. "
                "Is the ByteBuffer initialized?");
    }
}

class b2PolygonShape : public b2Shape {
public:
    b2PolygonShape();

    void SetAsBox(float32 hx, float32 hy);
    void SetCentroid(float32 x, float32 y);
    void SetAsBox(float32 hx,
                  float32 hy,
                  float32 centerX,
                  float32 centerY,
                  float32 angle);
    void Set(b2Vec2 *points, int32 count);
};

/// Clear the typemaps
%clear (b2Vec2 *points, int32 count);

