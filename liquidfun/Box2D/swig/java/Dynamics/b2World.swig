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

%module b2World

/// Forward declarations
class b2Body;

/// b2World class
class b2World {
public:
	b2World(float32 gravityX, float32 gravityY);
    ~b2World();

    void SetDebugDraw(b2Draw* debugDraw);
    void DrawDebugData();
    b2Body* CreateBody(const b2BodyDef* def);
    void DestroyBody(b2Body* body);
    void Step(
            float32 timeStep,
            int32 velocityIterations,
            int32 positionIterations,
            int32 particleIterations);
    int32 GetBodyCount() const;
    b2Body* GetBodyList();
    b2ParticleSystem* CreateParticleSystem(const b2ParticleSystemDef* def);
    void SetGravity(float32 gravityX, float32 gravityY);
    void QueryShapeAABB(b2QueryCallback *callback, const b2Shape &shape, const b2Transform &xf) const;
    int CalculateReasonableParticleIterations(float32 timeStep) const;
	void SetContactListener(b2ContactListener *listener);
	const b2Contact * GetContactList() const;
	int32 GetContactCount() const;
	b2Joint* CreateJoint(const b2JointDef* def);
	void DestroyJoint(b2Joint* joint);
};

