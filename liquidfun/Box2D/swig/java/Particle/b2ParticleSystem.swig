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

%module b2ParticleSystem

// error enums and strings for Java exceptions
%{
enum b2ExceptionType {
    BUFFER_TOO_SMALL,
    PARTICLE_INDEX_OUTOFBOUNDS,
    NUM_ERRORS,
    NO_EXCEPTIONS,
};

struct b2Exception {
    const char* jniType;
    const char* errorMsg;
} g_liquidfunExceptions[NUM_ERRORS] = {
    {"java/lang/IllegalArgumentException",
         "Supplied buffer is too small"},
    {"java/lang/ArrayIndexOutOfBoundsException",
        "Particle index is out of bounds. Check startIndex and numParticles."},
};
%}

// Typemaps for all the Copy*Buffer functions.
%typemap(jni) (void* outBuf, int size) "jobject"
%typemap(jtype) (void* outBuf, int size) "java.nio.ByteBuffer"
%typemap(jstype) (void* outBuf, int size) "java.nio.ByteBuffer"
%typemap(javain) (void* outBuf, int size) "$javainput"
%typemap(javaout) (void* outBuf, int size) {
    return $jnicall;
}
// This extracts the Java ByteBuffer address from C++
%typemap(in) (void* outBuf, int size) {
    $1 = jenv->GetDirectBufferAddress($input);
    $2 = jenv->GetDirectBufferCapacity($input);
    if (($1 == NULL) && ($2 != 0)) {
        SWIG_JavaThrowException(
                jenv,
                SWIG_JavaRuntimeException,
                "Unable to get address of java.nio.ByteBuffer. "
                "Is the ByteBuffer initialized?");
    }
}
// This checks the output of the C++ functions for exceptions
%typemap(argout) (void* outBuf, int size) {
    if($result != NO_EXCEPTIONS) {
        jclass clazz = jenv->FindClass(
                g_liquidfunExceptions[$result].jniType);
        jenv->ThrowNew(clazz, g_liquidfunExceptions[$result].errorMsg);
    }
}


// Typemaps for GetPositionBuffer() and GetVelocityBuffer().
%typemap(jni) b2Vec2* "jobject"
%typemap(jtype) b2Vec2* "java.nio.ByteBuffer"
%typemap(jstype) b2Vec2* "java.nio.ByteBuffer"
%typemap(javain) b2Vec2* "$javainput"
%typemap(javaout) b2Vec2* {
    return $jnicall;
}
// This instantiates a new ByteBuffer on every call, which is not optimal. But if
// we cache the ByteBuffer, then we'd also have to re-create it when the underlying
// buffer is reallocated, which is tricky. 
%typemap(out) b2Vec2* {
	jresult = jenv->NewDirectByteBuffer($1, (arg1->GetParticleCount() * sizeof(b2Vec2)));
}


// Typemaps for GetColorBuffer().
%typemap(jni) b2ParticleColor* "jobject"
%typemap(jtype) b2ParticleColor* "java.nio.ByteBuffer"
%typemap(jstype) b2ParticleColor* "java.nio.ByteBuffer"
%typemap(javain) b2ParticleColor* "$javainput"
%typemap(javaout) b2ParticleColor* {
    return $jnicall;
}
%typemap(out) b2ParticleColor* {
	jresult = jenv->NewDirectByteBuffer($1, (arg1->GetParticleCount() * sizeof(b2ParticleColor)));
}


// Disallow constructors and destructors; only made through b2World
%nodefaultctor b2ParticleSystem;
%nodefaultdtor b2ParticleSystem;
class b2ParticleSystem {
public:
    int32 CreateParticle(const b2ParticleDef& def);
    void JoinParticleGroups(b2ParticleGroup* groupA, b2ParticleGroup* groupB);
    const b2ParticleGroup* GetParticleGroupList() const;
    void DestroyParticlesInShape(const b2Shape& shape, const b2Transform& xf);
    b2ParticleGroup* CreateParticleGroup (const b2ParticleGroupDef &def);
    int32 GetParticleGroupCount() const;
    int32 GetParticleCount() const;
    void SetMaxParticleCount(int32 count);
    void SetDamping(float32 damping);
    void SetRadius(float32 radius);

    void QueryShapeAABB(
            b2QueryCallback* callback,
            const b2Shape& shape,
            const b2Transform& xf) const;

    void SetParticleVelocity(int32 index, float32 vx, float32 vy);
    float GetParticlePositionX(int32 index) const;
    float GetParticlePositionY(int32 index) const;

	const b2ParticleContact* GetContacts() const;
	int32 GetContactCount() const;
	const b2ParticleBodyContact* GetBodyContacts() const;
	int32 GetBodyContactCount() const;

	b2Vec2* GetPositionBuffer();
	b2Vec2* GetVelocityBuffer();
	b2ParticleColor* GetColorBuffer();

    int CopyPositionBuffer(
            int startIndex, int numParticles, void* outBuf, int size) const;
    int CopyColorBuffer(
            int startIndex, int numParticles, void* outBuf, int size) const;
    int CopyWeightBuffer(
            int startIndex, int numParticles, void* outBuf, int size) const;
};


// Ignore the original version of b2ParticleSystem as it's too complex
%ignore b2ParticleSystem;

// Ignore warning about != operator
%warnfilter(503) b2ParticleContact::operator!=;

/// Include original .h file for SWIG
/// The original file is simple enough we will just pull it in
%include "../../../Box2D/Box2D/Particle/b2ParticleSystem.h"

/// Clear the typemaps
%clear (void* outBuf, int size);
%clear b2Vec2*;

