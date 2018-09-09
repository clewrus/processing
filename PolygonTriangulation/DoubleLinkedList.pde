import java.util.Iterator;
import java.util.List;

class DoubleLinkedList<T>{
  public DoubleLinkedList(){
    first = null;
    last = null;
    size = 0;
  }
  
  public DoubleLinkedList(List<T> l){
    this();
    for(T x: l){
      addLast(x);
    }
  }
  
  public DoubleIterator iterator(T tarT){
    if(first == null) return null;
    
    ListNode curEl = first;
    boolean flag = true;
    while(curEl != first || flag){
      flag = false;
      if(((NamedDot)curEl.val()).eq((NamedDot)tarT)){
        return new DoubleIterator(curEl);
      }
      curEl = curEl.next();
    }
    return null;
  }
  // TODO every ListNode must have link to its list
  //      have to cheke it the node beloth to this list
  public void removeNode(ListNode n){
    if(n == first){
      first = n.next();
    }
    if(n == last){
      last = n.prev();
    }
    n.rem();
    size --;
    if(size == 1){
      last = null;
    }
    if(size == 0){
      first = null;
    }
  }
  
  public DoubleIterator iterator(){
    return new DoubleIterator(first);
  }
  
  public ListNode addLast(T val){
    ListNode result = null;
    if(first == null){
      first = new ListNode(val);
      result = first;
    } else if(last == null){
      last = new ListNode(first, first, val);
      first.next(last);
      first.prev(last);
      result = last;
    } else {
      last = new ListNode(last, first, val);
      last.prev().next(last);
      first.prev(last);
      result = last;
    }
    size ++;
    return result;
  }
  
  public int size(){
    return size;
  }
  
  private int size;
  private ListNode first;
  private ListNode last;
  
  public class DoubleIterator implements Iterator<T>{
    DoubleIterator(ListNode firstNode){
      this.curNode = firstNode;
      this.firstNode = firstNode;
      this.neverUsed = true;
    }
    
    public void remove(){
      ListNode temp = curNode.next();
      removeNode(curNode);
      curNode = temp;
    }
    
    public T next(){
      T res = curNode.val();
      curNode = curNode.next();
      neverUsed = false;
      return res;
    }
    
    public T val(){
      return curNode.val();
    }
    
    public ListNode getNode(){
      return this.curNode;
    }
    
    public T prev(){
      curNode = curNode.prev();
      neverUsed = false;
      return curNode.val();
    }
    
    public boolean hasNext(){
      return curNode != null && curNode.next() != null && !(curNode == firstNode && !neverUsed);
    }
    
    public boolean hasPrev(){
      return curNode.prev() != null;
    }
    
    public void updateIterator(){
      curNode = firstNode;
      neverUsed = true;
    }
    
    private boolean neverUsed;
    private ListNode curNode;
    private ListNode firstNode;
  }
  
  private class ListNode{
    ListNode(ListNode prev, ListNode next, T value){
      this.prev = prev;
      this.next = next;
      this.value = value;
    }
    
    ListNode(T value){
      this.prev = this;
      this.next = this;
      this.value = value;
    }
    
    public ListNode next(){
      return this.next;
    }
    
    public void rem(){
      this.prev.next(this.next);
      this.next.prev(this.prev);
    }
    
    public void next(ListNode nxt){
      this.next = nxt;
    }
    
    public ListNode prev(){
      return this.prev;
    }
    
    public void prev(ListNode prv){
      this.prev = prv;
    }
    
    public T val(){
      return this.value;
    }
    
    private ListNode prev;
    private ListNode next;
    private T value;
  }
}