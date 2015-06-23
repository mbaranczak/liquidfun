%module UserObject

%{ typedef int _marker_UserObject_destroyGlobalRef; %}

%typemap(in) jobject {
	$1 = jenv->NewGlobalRef($input); // create global ref to contained data
}
%typemap(out) _marker_UserObject_destroyGlobalRef {
	jenv->DestroyGlobalRef(jarg1_); // destroy global ref to current Java object..
	jenv->DestroyGlobalRef(arg1->GetData()); // ..and to the contained data
}

class UserObject {
public:
	UserObject(jobject jobj);
	jobject getData();
	void destroyGlobalRef();
};

%{
class UserObject {
public:	
	UserObject(jobject jobj) {
		data = jobj;
	}
	jobject getData() {
		return data;
	}
	_marker_UserObject_destroyGlobalRef __destroyGlobalRef() {
		return 0;
	}
	void destroyGlobalRef() {
		__destroyGlobalRef();
	}
private:
	jobject data;
};
%}

/// Clear the typemaps
%clear jobject;
%clear _marker_UserObject_destroyGlobalRef ;

