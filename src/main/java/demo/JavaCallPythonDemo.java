package demo;

import io.ray.api.ObjectRef;
import io.ray.api.PyActorHandle;
import io.ray.api.Ray;
import io.ray.api.function.PyActorClass;
import io.ray.api.function.PyActorMethod;
import io.ray.api.function.PyFunction;
import org.testng.Assert;

public class JavaCallPythonDemo {

  public static void main(String[] args) {
    System.out.println("JavaCallPython!");

    // Start the Ray cluster using the configuration
    Ray.init();

    // Define a Python class.
    PyActorClass actorClass = PyActorClass.of("ray_demo", "Counter");

    // Create a Python actor and call actor method.
    PyActorHandle actor = Ray.actor(actorClass).remote();
    System.out.println("Create a Python actor");
    ObjectRef objRef1 = actor.task(PyActorMethod.of("increment", int.class)).remote();
    Assert.assertEquals(objRef1.get(), 1);
    ObjectRef objRef2 = actor.task(PyActorMethod.of("increment", int.class)).remote();
    Assert.assertEquals(objRef2.get(), 2);

    // Call the Python remote function.
    ObjectRef objRef3 = Ray.task(PyFunction.of("ray_demo", "add", int.class), 1, 2).remote();
    Assert.assertEquals(objRef3.get(), 3);

    Ray.shutdown();
  }
}