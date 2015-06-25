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

%module b2Joint

%include "enums.swg"
%javaconst(1);

%nodefaultctor b2Joint;
%nodefaultdtor b2Joint;
%nodefaultctor b2JointEdge;
%nodefaultdtor b2JointEdge;

// Suppress warnings for overloaded functions, because SWIG will pick the
// non-const version automatically, which is what we want anyway.
%warnfilter(516) b2Joint::GetNext;

%ignore b2JointDef::userData;
%ignore b2Joint::GetUserData;
%ignore b2Joint::SetUserData;
%ignore b2Joint::Dump;
%ignore b2Joint::ShiftOrigin;
%ignore b2Joint::SetType;

%include "../../../Box2D/Box2D/Dynamics/Joints/b2Joint.h"

