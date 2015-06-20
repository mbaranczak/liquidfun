
%module b2Contact

%nodefaultctor;      // don't create default constructors
%nodefaultdtor;      // don't create default destructors

class b2Contact {
public:
	bool IsTouching() const;
	const b2Contact* GetNext() const;
	void SetEnabled(bool flag);
	bool IsEnabled() const;
	const b2Fixture * GetFixtureA() const;
	const b2Fixture * GetFixtureB() const;
	int32 GetChildIndexA() const;  
	int32 GetChildIndexB() const;
	void SetFriction(float32 friction);
	float32 GetFriction() const;
	void ResetFriction();
	void SetRestitution(float32 restitution);
	float32 GetRestitution() const;
	void ResetRestitution();
	void SetTangentSpeed(float32 speed);
	float32 GetTangentSpeed() const;
};
%clearnodefaultdtor; // Re-enable default constructors
%clearnodefaultctor; // Re-enable default destructors

