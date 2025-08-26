// Package first
package First;

public class GFG2 {

    public static void main(String[] args)
    {
        // Creating of instance of second class present
        // in the same project
        GFG1 ob = new GFG1(1, 2);
        System.out.println("Addition " + ob.add());
    }
}