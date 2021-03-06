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

%module(directors="1") b2WorldCallbacks;

%feature("director") b2QueryCallback;
%typemap(javaclassmodifiers) b2QueryCallback "public abstract class";

/// Forward declarations
class b2ParticleSystem;

%nodefaultctor b2QueryCallback;
class b2QueryCallback
{
public:
    b2QueryCallback() {}
    virtual ~b2QueryCallback();
    virtual bool ReportFixture(b2Fixture* fixture) = 0;
    virtual bool ReportParticle(const b2ParticleSystem* particleSystem, int32 index);
    virtual bool ShouldQueryParticleSystem(const b2ParticleSystem *particleSystem);
};



%feature("director") b2ContactListener;
%typemap(javaclassmodifiers) b2ContactListener "public abstract class";

%nodefaultctor b2ContactListener;
class b2ContactListener
{
public:
	b2ContactListener() {}
	virtual ~b2ContactListener();
	virtual void BeginContact(b2Contact* contact);
	virtual void EndContact(b2Contact* contact);
	virtual void BeginContact(b2ParticleSystem* particleSystem,
							  b2ParticleBodyContact* particleBodyContact);
	virtual void EndContact(b2Fixture* fixture,
							b2ParticleSystem* particleSystem, int32 index);
	virtual void BeginContact(b2ParticleSystem* particleSystem,
							  b2ParticleContact* particleContact);
	virtual void EndContact(b2ParticleSystem* particleSystem,
							int32 indexA, int32 indexB);
	//virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
	//virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
};


